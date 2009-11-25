# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils confutils subversion

DESCRIPTION="Redmine is a flexible project management web application written using Ruby on Rails framework"
HOMEPAGE="http://www.redmine.org/"
SRC_URI=""
ESVN_REPO_URI="http://redmine.rubyforge.org/svn/trunk"


KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="cvs darcs git imagemagick mercurial mysql openid postgres sqlite3 subversion"

DEPEND="|| (
		(
			dev-ruby/rails:2.3
			dev-ruby/activerecord:2.3[mysql?,postgres?,sqlite3?]
		)
		(
			>=dev-ruby/rails-2.2.2:2.2
			dev-ruby/activerecord:2.2[mysql?,postgres?,sqlite3?]
		)
	)
	imagemagick? ( dev-ruby/rmagick )
	openid? ( dev-ruby/ruby-openid )"

RDEPEND="${DEPEND}
	>=dev-ruby/ruby-net-ldap-0.0.4
	>=dev-ruby/coderay-0.7.6.227
	cvs? ( >=dev-util/cvs-1.12 )
	darcs? ( dev-util/darcs )
	git? ( dev-util/git )
	mercurial? ( dev-util/mercurial )
	subversion? ( >=dev-util/subversion-1.3 )"

REDMINE_DIR="/var/lib/${PN}"

pkg_setup() {
	confutils_require_any mysql postgres sqlite3

	enewgroup redmine
	# home directory is required for SCM.
	enewuser  redmine -1 -1 "${REDMINE_DIR}" redmine
}

src_prepare() {
	rm -fr log files/delete.me
	rm -fr vendor/plugins/coderay-0.7.6.227
	rm -fr vendor/plugins/ruby-net-ldap-0.0.4
	echo "CONFIG_PROTECT=\"${REDMINE_DIR}/config\"" > "${T}/50${PN}"
}

src_install() {
	dodoc doc/{CHANGELOG,INSTALL,README_FOR_APP,RUNNING_TESTS,UPGRADING}
	rm -fr doc

	keepdir /var/log/${PN}
	dosym /var/log/${PN}/ "${REDMINE_DIR}/log"

	insinto "${REDMINE_DIR}"
	doins -r . || die
	keepdir "${REDMINE_DIR}/files"
	keepdir "${REDMINE_DIR}/public/plugin_assets"

	fowners -R redmine:redmine \
		"${REDMINE_DIR}/config/environment.rb" \
		"${REDMINE_DIR}/files" \
		"${REDMINE_DIR}/public/plugin_assets" \
		"${REDMINE_DIR}/tmp" \
		/var/log/${PN} || die
	# for SCM
	fowners redmine:redmine "${REDMINE_DIR}" || die

	newconfd "${FILESDIR}/redmine.confd" redmine || die
	newinitd "${FILESDIR}/redmine.initd" redmine || die
	doenvd "${T}/50${PN}" || die
}

pkg_postinst() {
	einfo
	elog "Execute the following command to initlize environment:"
	elog
	elog "# cd ${REDMINE_DIR}"
	elog "# cp config/database.yml.example config/database.yml"
	elog "# ${EDITOR:-/usr/bin/nano} config/database.yml"
	elog "# emerge --config =${PF}"
	elog
	elog "Execute the following command to upgrade environment:"
	elog
	elog "# emerge --config =${PF}"
	elog
	elog "Installation notes are at official site"
	elog "http://www.redmine.org/wiki/redmine/RedmineInstall"
	elog
	elog "For upgrade instructions take a look at:"
	elog "http://www.redmine.org/wiki/redmine/RedmineUpgrade"
	einfo
}

pkg_config() {
	if [ ! -e "${REDMINE_DIR}/config/database.yml" ] ; then
		eerror "Copy ${REDMINE_DIR}/config/database.yml.example to ${REDMINE_DIR}config/database.yml and edit this file in order to configure your database settings for \"production\" environment."
		die
	fi

	local RAILS_ENV=${RAILS_ENV:-production}

	cd "${REDMINE_DIR}"
	if [ -e "${REDMINE_DIR}/config/initializers/session_store.rb" ] ; then
		einfo
		einfo "Upgrade database."
		einfo

		einfo "Migrate database."
		RAILS_ENV="${RAILS_ENV}" rake db:migrate || die
		einfo "Upgrade the plugin migrations."
		RAILS_ENV="${RAILS_ENV}" rake db:migrate:upgrade_plugin_migrations # || die
		RAILS_ENV="${RAILS_ENV}" rake db:migrate_plugins || die
		einfo "Clear the cache and the existing sessions."
		rake tmp:cache:clear || die
		rake tmp:sessions:clear || die
	else
		einfo
		einfo "Initialize database."
		einfo

		einfo "Generate a session store secret."
		rake config/initializers/session_store.rb || die
		einfo "Create the database structure."
		RAILS_ENV="${RAILS_ENV}" rake db:migrate || die
		einfo "Insert default configuration data in database."
		RAILS_ENV="${RAILS_ENV}" rake redmine:load_default_data || die
	fi

}
