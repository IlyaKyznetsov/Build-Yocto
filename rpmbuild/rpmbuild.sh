#!/usr/bin/bash -x
PROJECT='untitled'
#VERSION='0.1'
#PV="${PROJECT}-${VERSION}"
#cp -Rvf ../${PROJECT} ../${PV}
#tar -czvf ../${PV}.tar.gz ../${PV}
#cp -vf ../${PV}.tar.gz ~/rpmbuild/SOURCES/
#rm -Rf ../${PV}
#rpmbuild -bb --clean --rmsource ${PROJECT}.spec

tar -czvf ${HOME}/rpmbuild/SOURCES/${PROJECT}.tar.gz ../${PROJECT}
rpmbuild -bb --clean --rmsource ${PROJECT}.spec
