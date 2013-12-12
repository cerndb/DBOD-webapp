RPMBUILD=rpmbuild
RPMFLAGS=-bb
SRCPATH=/usr/src/redhat
SPECPATH=$(SRCPATH)/SPECS
SOURCESPATH=$(SRPATH)/SOURCES
DBODUTILS=/ORA/dbs03/DODUTILS
PKGSPATH=$(DBODUTILS)/rpms

install-daemon:
	cd daemon/dbod_daemon && \
	make clean && perl Makefile.PL && make install

daemon/dbod_daemon/dbod_daemon-$(VERSION).tar.gz:
	cd daemon/dbod_daemon && \
	make clean && perl Makefile.PL && make dist

rpm-daemon: daemon/dbod_daemon/dbod_daemon-$(VERSION).tar.gz 
	cp daemon/dbod_daemon/dbod_daemon-$(VERSION).tar.gz $(SOURCESPATH)
	export DAEMON_VERSION=$(VERSION) && $(RPMBUILD) $(RPMFLAGS) packages/dbod-daemon.spec

rpm-mysql:
	cp $(DBODUTILS)/mysql/mysql-$(VERSION).tar.gz $(SOURCESPATH)
	export MYSQL_VERSION=$(VERSION) && $(RPMBUILD) $(RPMFLAGS) packages/dbod-mysql-server.spec

rpm-mariadb:
	cp $(DBODUTILS)/mariadb/mariadb-$(VERSION).tar.gz $(SOURCESPATH)
	export MARIADB_VERSION=$(VERSION) && $(RPMBUILD) $(RPMFLAGS) packages/dbod-mariadb-server.spec

rpm-postgres:
	cp $(DBODUTILS)/pgsql/postgresql-$(VERSION).tar.gz $(SOURCESPATH)
	export PG_VERSION=$(VERSION) && $(RPMBUILD) $(RPMFLAGS) packages/dbod-postgresql-server.spec

clean:

