# Create spec
SPEC_PATH=$${_PRO_FILE_PWD_}/$${TARGET}.spec
system(rm -Rf $${SPEC_PATH})
system(touch $${SPEC_PATH})
system(echo \'Name:          $${TARGET}\' >> $${SPEC_PATH})
system(echo \'Version:       0.1\' >> $${SPEC_PATH})
system(echo \'Release:       1%{?dist}\' >> $${SPEC_PATH})
system(echo \'Summary:       $${TARGET}\' >> $${SPEC_PATH})
system(echo \'Group:         Soop/$$TEMPLATE\' >> $${SPEC_PATH})
system(echo \'License:       GPL-2.0+\' >> $${SPEC_PATH})
#system(echo \'URL:           localhost\' >> $${SPEC_PATH})
#system(echo \'Source0:       http://localhost/%{name}.tar.gz\' >> $${SPEC_PATH})
system(echo \'Source0:       %{name}.tar.gz\' >> $${SPEC_PATH})

system(echo \'BuildArch:     x86_64\' >> $${SPEC_PATH})
#system(echo \'BuildArch:     noarch\' >> $${SPEC_PATH})
#system(echo \'ExclusiveArch: {go_arches} noarch\' >> $${SPEC_PATH})
#system(echo \'ExclusiveArch: armv7l\' >> $${SPEC_PATH})
system(echo \'ExclusiveArch: x86_64\' >> $${SPEC_PATH})

for(item, QT):\
    system(echo \'BuildRequires: pkgconfig(Qt5$$upper($$str_member($$item, 0, 0))$$str_member($$item, 1, -1))\' >> $${SPEC_PATH})
#for(item, QT):\
#    system(echo \'Requires: pkgconfig(Qt5$$upper($$str_member($$item, 0, 0))$$str_member($$item, 1, -1))\' >> $${SPEC_PATH})

system(echo \'%global debug_package %{nil}\' >> $${SPEC_PATH})
#system(echo \'%define SOOP_HOME /usr/local/soop\' >> $${SPEC_PATH})
system(echo \'%description\' >> $${SPEC_PATH})
system(echo \'description text\' >> $${SPEC_PATH})
system(echo \'%prep\' >> $${SPEC_PATH})
system(echo \'%setup -qn %{name}\' >> $${SPEC_PATH})
system(echo \'%build\' >> $${SPEC_PATH})
system(echo \'qmake-qt5 -makefile %{name}.pro\' >> $${SPEC_PATH})
system(echo \'qmake-qt5\' >> $${SPEC_PATH})
system(echo \'make\' >> $${SPEC_PATH})
#system(echo \'%clean\' >> $${SPEC_PATH})
#system(echo \'make distclean\' >> $${SPEC_PATH})
system(echo \'%install\' >> $${SPEC_PATH})
system(echo \'make install INSTALL_ROOT=%{buildroot} $INSTALL_TARGET\' >> $${SPEC_PATH})
system(echo \'%files\' >> $${SPEC_PATH})
system(echo \'%defattr(-,root,root)\' >> $${SPEC_PATH})
#system(echo \'%{SOOP_HOME}/bin/%{name}\' >> $${SPEC_PATH})
#system(echo \'$${target.path}/%{name}\' >> $${SPEC_PATH})
system(echo \'$${target.path}/%{name}*\' >> $${SPEC_PATH})
system(echo \'%changelog\' >> $${SPEC_PATH})

RPM_SOURCES=$$(HOME)/rpmbuild/SOURCES
system([ ! -d $${RPM_SOURCES} ] && mkdir $${RPM_SOURCES})
PROJECT_TARBALL=$${RPM_SOURCES}/$${TARGET}.tar.gz
message("Create source project tarball: $${PROJECT_TARBALL}")
system(rm -Rf $${PROJECT_TARBALL})
system(cd $(dirname $${_PRO_FILE_PWD_}) && tar -czvf $${PROJECT_TARBALL} $(basename $${_PRO_FILE_PWD_}))
#system(cd $${_PRO_FILE_PWD_} && tar -czvf $${RPM_BUILD_SOURCES_PATH}/$${TARGET}.tar.gz *)
#system(rpmbuild -bb --clean --rmsource *.spec)
