calc_repo_dirs(){
	get_list(){
		local path=$1
		local next
		if [[ -e $path/parent ]]
		then
			while IFS= read -r line
			do
				if [[ $line =~ ^[a-z0-9]+: ]]
				then
					next=$(realpath /var/db/repos/${line%%:*}/profiles/${line#*:})
				elif [[ ${line:0:1} == / ]]
				then
					next=$(realpath $line)
				else
					next=$(realpath $path/$line)
				fi
				get_list $next
				echo $next
			done < $1/parent
		fi
	}
	get_list $(realpath /etc/portage/make.profile)
}

calc_ini_files(){
	local path
	for path in $(calc_repo_dirs) \
		/var/lib/calculate/calculate-update \
		/var/lib/calculate \
		/etc/calculate \
		/var/calculate \
		/var/calculate/remote
	do
		if [[ -e $path/ini.env ]]
		then
			echo $path/ini.env
		fi
	done
}

# The function reads values from all ini.env files into the ini array
# Create an array before calling `declare -A ini; get_ini`
get_ini(){
	local line sec ini_file
	for ini_file in $(calc_ini_files)
	do
		while IFS= read -r line
		do
		        if [[ $line == *"["* ]]
		        then
		                line=${line#*[}
		                line=${line%%]*}
		                sec=$line
		                continue
		        fi
			if [[ $line =~ ^[[:blank:]]*[#\;] || $line == '' ]]
			then
				continue
			fi
			local var=${sec}.${line%%=*}
			# remove trailing whitespace characters
			var=${var%${var##*[![:space:]]}}
			local val=${line#*=}
			# remove leading whitespace characters
			val=${val#${val%%[![:space:]]*}}

			ini[$var]=$val
		done < $ini_file
	done
}

