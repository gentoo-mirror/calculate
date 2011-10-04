#!/usr/bin/perl

use FCGI;
use FCGI::ProcManager; #!!!
use Socket;
use POSIX qw(setsid);
require 'syscall.ph';

my $PROCESSES = 100;

#&daemonize;

#this keeps the program alive or something after exec'ing perl scripts
END() { } BEGIN() { }
*CORE::GLOBAL::exit = sub { die "fakeexit\nrc=".shift()."\n"; }; 
eval q{exit}; 
if ($@) { 
	exit unless $@ =~ /^fakeexit/; 
};

&main;

sub daemonize() {
	chdir '/'                 or die "Can't chdir to /: $!";
	defined(my $pid = fork)   or die "Can't fork: $!";
	exit if $pid;
	setsid                    or die "Can't start a new session: $!";
	umask 0;
}

sub main {
	$proc_manager = new FCGI::ProcManager({ n_processes => $PROCESSES, die_timeout => 10 }); #!!!
	$socket = FCGI::OpenSocket( "/var/run/nginx/cgiwrap-dispatch.sock", 10 ); #use UNIX sockets - user running this script must have w access to the 'nginx' folder!!
	`/bin/chown nginx:nginx /var/run/nginx/cgiwrap-dispatch.sock`;
	$request = FCGI::Request( \*STDIN, \*STDOUT, \*STDERR, \%req_params, $socket, FCGI::FAIL_ACCEPT_ON_INTR );
	if ($request) { request_loop()};
	FCGI::CloseSocket( $socket );
}

sub request_loop {
	$proc_manager->pm_manage();
	while( $request->Accept() >= 0 ) {
		$proc_manager->pm_pre_dispatch(); #!!!
		#processing any STDIN input from WebServer (for CGI-POST actions)
		$stdin_passthrough = '';
		$req_len = 0 + $req_params{'CONTENT_LENGTH'};
		if (($req_params{'REQUEST_METHOD'} eq 'POST') && ($req_len != 0) ){ 
			my $bytes_read = 0;
			while ($bytes_read < $req_len) {
				my $data = '';
				my $bytes = read(STDIN, $data, ($req_len - $bytes_read));
				last if ($bytes == 0 || !defined($bytes));
				$stdin_passthrough .= $data;
				$bytes_read += $bytes;
			}
		}
		#running the cgi app
		if ( (-x ($req_params{SCRIPT_FILENAME})) &&  #can I execute this?
				(-s ($req_params{SCRIPT_FILENAME})) &&  #Is this file empty?
				(-r ($req_params{SCRIPT_FILENAME}))     #can I read this file?
		){
			pipe(CHILD_RD, PARENT_WR);
			my $pid = open(KID_TO_READ, "-|");
			unless(defined($pid)) {
				print("Content-type: text/plain\r\n\r\n");
							print "Error: CGI app returned no output - Executing $req_params{SCRIPT_FILENAME} failed !\n";                        
			}
			else {
				if ($pid > 0) {
					close(CHILD_RD);
					print PARENT_WR $stdin_passthrough;
					close(PARENT_WR);
					while(my $s = <KID_TO_READ>) { print $s; }
					close KID_TO_READ;
					waitpid($pid, 0);
				} else {
					foreach ( keys %req_params){
						$ENV{$_} = $req_params{$_};
					}
					# cd to the script's local directory
					if ($req_params{SCRIPT_FILENAME} =~ /^(.*)\/[^\/]+$/) {
						chdir $1;
					}
					close(PARENT_WR);
					close(STDIN);
					#fcntl(CHILD_RD, F_DUPFD, 0);
					syscall(&SYS_dup2, fileno(CHILD_RD), 0);
					#open(STDIN, "<&CHILD_RD");
					exec($req_params{SCRIPT_FILENAME});
					die("exec failed");
				}
			}
		}
		else {
			print("Content-type: text/plain\r\n\r\n");
			print "Error: No such CGI app - $req_params{SCRIPT_FILENAME} may not exist or is not executable by this process.\n";
		}
		$proc_manager->pm_post_dispatch(); #!!!
	}
}
