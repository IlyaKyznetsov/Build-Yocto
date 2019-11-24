QT -= gui
QT += network xml gui concurrent

TEMPLATE = lib
DEFINES += LIB_LIBRARY

CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    lib.cpp

HEADERS += \
    lib_global.h \
    lib.h

# Default rules for deployment.
unix {
    target.path = /usr/local/soop/lib
}
!isEmpty(target.path): INSTALLS += target

message(installs: $$INSTALLS)
message(installs: $$target.files)
message(installs: $$target.path)

# Create spec
system(rm -Rf $${TARGET}.spec)
system(touch $${TARGET}.spec)
system(echo \'Name:          $${TARGET}\' >> $${TARGET}.spec)
system(echo \'Version:       0.1\' >> $${TARGET}.spec)
system(echo \'Release:       1%{?dist}\' >> $${TARGET}.spec)
system(echo \'Summary:       $${TARGET}\' >> $${TARGET}.spec)
system(echo \'Group:         Soop/$$TEMPLATE\' >> $${TARGET}.spec)
system(echo \'License:       GPL-2.0+\' >> $${TARGET}.spec)
#system(echo \'URL:           localhost\' >> $${TARGET}.spec)
#system(echo \'Source0:       http://localhost/%{name}.tar.gz\' >> $${TARGET}.spec)
system(echo \'Source0:       %{name}.tar.gz\' >> $${TARGET}.spec)

system(echo \'BuildArch:     x86_64\' >> $${TARGET}.spec)
#system(echo \'BuildArch:     noarch\' >> $${TARGET}.spec)
#system(echo \'ExclusiveArch: {go_arches} noarch\' >> $${TARGET}.spec)
#system(echo \'ExclusiveArch: armv7l\' >> $${TARGET}.spec)
system(echo \'ExclusiveArch: x86_64\' >> $${TARGET}.spec)

for(item, QT):\
    system(echo \'BuildRequires: pkgconfig(Qt5$$upper($$str_member($$item, 0, 0))$$str_member($$item, 1, -1))\' >> $${TARGET}.spec)
#for(item, QT):\
#    system(echo \'Requires: pkgconfig(Qt5$$upper($$str_member($$item, 0, 0))$$str_member($$item, 1, -1))\' >> $${TARGET}.spec)

system(echo \'%global debug_package %{nil}\' >> $${TARGET}.spec)
#system(echo \'%define SOOP_HOME /usr/local/soop\' >> $${TARGET}.spec)
system(echo \'%description\' >> $${TARGET}.spec)
system(echo \'description text\' >> $${TARGET}.spec)
system(echo \'%prep\' >> $${TARGET}.spec)
system(echo \'%setup -qn %{name}\' >> $${TARGET}.spec)
system(echo \'%build\' >> $${TARGET}.spec)
system(echo \'qmake-qt5 -makefile %{name}.pro\' >> $${TARGET}.spec)
system(echo \'qmake-qt5\' >> $${TARGET}.spec)
system(echo \'make\' >> $${TARGET}.spec)
system(echo \'%clean\' >> $${TARGET}.spec)
system(echo \'make distclean\' >> $${TARGET}.spec)
system(echo \'%install\' >> $${TARGET}.spec)
system(echo \'make install INSTALL_ROOT=%{buildroot} $INSTALL_TARGET\' >> $${TARGET}.spec)
system(echo \'%files\' >> $${TARGET}.spec)
system(echo \'%defattr(-,root,root)\' >> $${TARGET}.spec)
#system(echo \'%{SOOP_HOME}/bin/%{name}\' >> $${TARGET}.spec)
#system(echo \'$${target.path}/%{name}\' >> $${TARGET}.spec)
system(echo \'$${target.path}/%{name}*\' >> $${TARGET}.spec)
system(echo \'%changelog\' >> $${TARGET}.spec)

DISTFILES += \
    lib.spec
