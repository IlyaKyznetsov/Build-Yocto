Name:           untitled
Version:        0.1
Release:        1%{?dist}
Summary:        Test Application rpm
Group:          Soop/Application
License:        GPL-2.0+

URL:            localhost
Source0:        http://localhost/%{name}.tar.gz

BuildRequires:  qt5-qtbase-devel
BuildRequires:  qt5-qttools-devel
BuildRequires:  gcc-c++
BuildRequires:  pkgconfig(Qt5Concurrent)
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5DBus)
BuildRequires:  pkgconfig(Qt5Gui)
BuildRequires:  pkgconfig(Qt5Network)
BuildRequires:  pkgconfig(Qt5PrintSupport)
BuildRequires:  pkgconfig(Qt5Sql)
BuildRequires:  pkgconfig(Qt5Widgets)
BuildRequires:  pkgconfig(Qt5Xml)

%define SOOP_HOME /usr/local/soop

%description
Soop Test Application

%global debug_package %{nil}

%prep
%setup -qn %{name}

%build
qmake-qt5 -makefile %{name}.pro
qmake-qt5
make

%install
make install INSTALL_ROOT=%{buildroot} $INSTALL_TARGET

%files
%defattr(-,root,root)
%{SOOP_HOME}/bin/%{name}

%changelog
