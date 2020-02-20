%global     reponame  rpmfusion
%global     repoversion nonfree

Name:       %{reponame}-%{repoversion}-appstream-data
Version:    33
Release:    1%{?dist}
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
* Thu Feb 20 2020 Leigh Scott <leigh123linux@gmail.com> - 33-1
- Update for rawhide

* Sun Oct 27 2019 Leigh Scott <leigh123linux@gmail.com> - 32-1
- Update for rawhide

* Sun Oct 21 2018 Ankur Sinha <ankursinha AT fedoraproject DOT org> - 30-1.20181021
- Regenerate
- Use datestamp to indicate regeneration date.

* Sun Jul 08 2018 Ankur Sinha <ankursinha AT fedoraproject DOT org> - 29-2
- Regenerate

* Sat Mar 31 2018 Ankur Sinha <ankursinha AT fedoraproject DOT org> - 29-1
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
