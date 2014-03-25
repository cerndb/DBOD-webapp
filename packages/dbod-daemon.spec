#
# Database On Demand (DBOD) Daemon SPEC file
#

# The version to be compiled must be passed via an environment variable
%define version %(echo $DAEMON_VERSION)

Summary: DB On Demand Job Dispatching Daemon 
Name: DBOD-daemon
Version: %{version}
Release: 0 
License: GPL
Group: Applications
Source: dbod_daemon-%{version}.tar.gz
URL: https://cern.ch/DBOnDemand/
Distribution: DBOD
Vendor: CERN
Packager: Ignacio Coterillo Coz <icoteril@cern.ch>

%description
DB On Demand Job Dispatching Daemon

#Requires: 

%prep
%setup -n dbod_daemon-%{version}

%build
#cd $(basename $PWD) # This won't be needed if tar wouldn't contain extra folder
perl Makefile.PL
make

%install
#cd $(basename $PWD) # This won't be needed if tar wouldn't contain extra folder
make install
# Creates configuration links
ln -f -s /usr/lib/perl5/site_perl/5.8.8/auto/dbod_daemon/dbod_daemon.conf \
 /usr/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi/auto/dbod_daemon/dbod_daemon.conf
ln -f -s /usr/lib/perl5/site_perl/5.8.8/auto/dbod_daemon/dbod_daemon_logger.conf \
 /usr/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi/auto/dbod_daemon/dbod_daemon_logger.conf
ln -f -s /usr/lib/perl5/site_perl/5.8.8/auto/dbod_daemon/templates/  \
 /usr/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi/auto/dbod_daemon/templates
# Creates start scripts
cp scripts/dbod_daemon_init /etc/init.d/dbod_daemon
for a in 0 1 6; do ln -f -s /etc/init.d/dbod_daemon /etc/rc$a.d/K85dbod_daemon; done
for a in 2 3 4 5; do ln -f -s /etc/init.d/dbod_daemon /etc/rc$a.d/S85dbod_daemon; done
# Creates running folders
mkdir -p /var/run/dbod_daemon
chown dbod:dbod /var/run/dbod_daemon/
mkdir -p /var/log/dbod_daemon
chown dbod:dbod /var/log/dbod_daemon/

%clean
rm -rf $RPM_BUILD_ROOT

%files
/usr/lib/perl5/site_perl/5.8.8/DBOD.pm
/usr/lib/perl5/site_perl/5.8.8/DBOD/Config.pm
/usr/lib/perl5/site_perl/5.8.8/DBOD/MySQL.pm
/usr/lib/perl5/site_perl/5.8.8/DBOD/Database.pm
/usr/lib/perl5/site_perl/5.8.8/DBOD/Command.pm
/usr/lib/perl5/site_perl/5.8.8/DBOD/Oracle.pm
/usr/lib/perl5/site_perl/5.8.8/DBOD/Middleware.pm
/usr/lib/perl5/site_perl/5.8.8/DBOD/PostgreSQL.pm
/usr/lib/perl5/site_perl/5.8.8/DBOD/LDAP.pm
/usr/lib/perl5/site_perl/5.8.8/DBOD/All.pm
/usr/bin/dbod_daemon
/usr/bin/dbod_state_checker
/usr/bin/dbod_daemon_monitor
/usr/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi/auto/dbod_daemon/.packlist
/etc/init.d/dbod_daemon
/etc/rc0.d/K85dbod_daemon
/etc/rc1.d/K85dbod_daemon
/etc/rc2.d/S85dbod_daemon
/etc/rc3.d/S85dbod_daemon
/etc/rc4.d/S85dbod_daemon
/etc/rc5.d/S85dbod_daemon
/etc/rc6.d/K85dbod_daemon
%attr (-, dbod, dbod) /var/run/dbod_daemon
%attr (-, dbod, dbod) /var/log/dbod_daemon
%doc /usr/share/man/man1/dbod_state_checker.1
%doc /usr/share/man/man1/dbod_daemon.1
%config /usr/lib/perl5/site_perl/5.8.8/auto/dbod_daemon/dbod_daemon.conf
%config /usr/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi/auto/dbod_daemon/dbod_daemon.conf
%config /usr/lib/perl5/site_perl/5.8.8/auto/dbod_daemon/dbod_daemon_logger.conf
%config /usr/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi/auto/dbod_daemon/dbod_daemon_logger.conf

%changelog
* Thu Feb 27 2014 Ignacio Coterillo <icoteril@cern.ch> 2.1 
- Added Oracle 12c Support, Removed configuration templates
* Wed Sep 18 2013 Ignacio Coterillo <icoteril@cern.ch> 2.0
- Added Middleware, PostgreSQL support and dbod_daemon_monitor
* Mon Apr 15 2013 Ignacio Coterillo <icoteril@cern.ch> 1.6
- Initial packaging
