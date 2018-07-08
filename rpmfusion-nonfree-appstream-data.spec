%global     reponame  rpmfusion
%global     repoversion nonfree

Name:       %{reponame}-%{repoversion}-appstream-data
Version:    28
Release:    3%{?dist}
Summary:    Appstream metadata for the RPM Fusion nonfree repository
BuildArch:  noarch

License:    CC0
URL:        http://rpmfusion.org

Source0:    %{reponame}-%{repoversion}-%{version}.xml.gz
Source1:    %{reponame}-%{repoversion}-%{version}-icons.tar.gz
Source2:    update-appdata-rpmfusion-nonfree.sh

BuildRequires:  libappstream-glib
Supplements:    appstream-data

%description
Appstream metadata for packages in the RPM Fusion nonfree repository


%prep


%build


%install
DESTDIR=%{buildroot} appstream-util install %{SOURCE0} %{SOURCE1}


%files
%attr(0644,root,root) %{_datadir}/app-info/xmls/%{reponame}-%{repoversion}-%{version}.xml.gz
%{_datadir}/app-info/icons/%{reponame}-%{repoversion}-%{version}/
%dir %{_datadir}/app-info
%dir %{_datadir}/app-info/icons
%dir %{_datadir}/app-info/xmls

%changelog
* Sun Jul 08 2018 Ankur Sinha <ankursinha AT fedoraproject DOT org> - 28-3
- Regenerate

* Sat Mar 31 2018 Ankur Sinha <ankursinha AT fedoraproject DOT org> - 28-2
- Regenerate

* Mon Nov 13 2017 Ankur Sinha <ankursinha AT fedoraproject DOT org> - 28-1
- Update appdata

* Sun Jul 09 2017 Ankur Sinha <ankursinha AT fedoraproject DOT org> - 26-2
- Regenerate and update

* Mon Nov 14 2016 Ankur Sinha <ankursinha AT fedoraproject DOT org> - 26-1
- Bump version and regenerate data with correct version

* Mon Nov 14 2016 Ankur Sinha <ankursinha AT fedoraproject DOT org> - 25-3
- Add weak dep on Fedora appstream-data package

* Mon Nov 14 2016 Ankur Sinha <ankursinha AT fedoraproject DOT org> - 25-2
- Regenerate and update

* Tue Jul 26 2016 Ankur Sinha <ankursinha AT fedoraproject DOT org> - 25-1
- Initial build for rawhide

* Tue Mar 08 2016 Nicolas Chauvet <kwizart@gmail.com> - 22-5
- Fix project name

* Wed May 27 2015 Ankur Sinha <ankursinha AT fedoraproject DOT org> 22-4
- Added some appdata files

* Fri May 22 2015 Ankur Sinha <ankursinha AT fedoraproject DOT org> 22-3
- regenerate with screenshots

* Thu May 21 2015 Ankur Sinha <ankursinha AT fedoraproject DOT org> 22-1
- Initial build
