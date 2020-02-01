# Git to archive:
#git clone git://git.kernel.org/pub/scm/network/ofono/phonesim.git
#cd phonesim
#git archive --format=tgz --prefix=phonesim-1.21/ HEAD --output=${HOME}/rpmbuild/SOURCES/phonesim-1.21.tar.gz
#cd ..
# rpmbuild phonesim.spec --define "debug_package %{nil}" 

Name:    phonesim
Summary: Phone Simulator for modem testing
Version: 1.21
Release: 1

License: GPLv2
URL: git://git.kernel.org/pub/scm/network/ofono/phonesim.git
Source0: phonesim-%{version}.tar.gz

BuildRequires:  pkgconfig(Qt5)

%description
Phone Simulator for modem testing

%prep
%setup -q


%build
if [ ! -f configure ]; then
./bootstrap
fi

%configure
%make_build


%install
%make_install

%check
make check

%files
/usr/bin/phonesim
/usr/share/phonesim/default.xml
