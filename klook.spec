#This is a spec file for Klook

Summary:	Klook is a quick preview feature
Name:		klook
Version:	0.1
Release:	39
License:	GPL v.3
Group:		Graphical desktop
Source:		%{name}-%{version}.tar.bz2
BuildRequires:	qt4-devel	>= 4.7.0
BuildRequires:	qt4-linguist	>= 4.2.0
BuildRequires:	kdelibs4-devel	>= 4.6.5
Requires:	dolphin
BuildRoot:	/tmp/klook-build

%description
Klook is a quick preview feature based on Qt and Qt Quick, allows users to look at the contents of a file in the Dolphin

%prep
%setup -c

%build
cd klook-%{version}
qmake klook.pro
lrelease -compress klook.pro
make

%install
cd klook-%{version}
make INSTALL_ROOT=$RPM_BUILD_ROOT install

%files
%{_libdir}/klook/main.qml
%{_libdir}/klook/Button.qml
%{_libdir}/klook/PlayButton.qml
%{_libdir}/klook/Slider.qml
%{_libdir}/klook/Delegate.qml
%{_libdir}/klook/ControlPanel.qml
%{_libdir}/klook/ControlPanelButton.qml
%{_libdir}/klook/ScrollBar.qml
%{_libdir}/klook/Preview.qml
%{_libdir}/klook/SingleDelegate.qml
%{_libdir}/klook/images/bg.png
%{_libdir}/klook/images/separator.png
%{_libdir}/klook/DefaultImage.qml
%{_libdir}/klook/images/go-next.png
%{_libdir}/klook/images/go-previous.png
%{_libdir}/klook/images/gallery.png
%{_libdir}/klook/images/play.png
%{_libdir}/klook/images/resume.png
%{_libdir}/klook/images/pause.png
%{_libdir}/klook/images/pla-empty-box.png
%{_libdir}/klook/images/play-empty.png
%{_libdir}/klook/images/close.png
%{_libdir}/klook/images/slider.png
%{_libdir}/klook/images/fullscreen.png
%{_libdir}/klook/images/buttons/normal/prev_normal.png
%{_libdir}/klook/images/buttons/normal/next_normal.png
%{_libdir}/klook/images/buttons/normal/gallery_normal.png
%{_libdir}/klook/images/buttons/normal/open_in_normal.png
%{_libdir}/klook/images/buttons/normal/fullscreen_normal.png
%{_libdir}/klook/images/buttons/normal/close_normal.png
%{_libdir}/klook/images/buttons/hover/prev_hover.png
%{_libdir}/klook/images/buttons/hover/next_hover.png
%{_libdir}/klook/images/buttons/hover/gallery_hover.png
%{_libdir}/klook/images/buttons/hover/open_in_hover.png
%{_libdir}/klook/images/buttons/hover/fullscreen_hover.png
%{_libdir}/klook/images/buttons/hover/close_hover.png
%{_libdir}/klook/images/buttons/disable/prev_disable.png
%{_libdir}/klook/images/buttons/disable/next_disable.png
%{_libdir}/klook/images/buttons/disable/gallery_disable.png
%{_libdir}/klook/images/buttons/disable/open_in_disable.png
%{_libdir}/klook/images/buttons/disable/fullscreen_disable.png
%{_libdir}/klook/images/buttons/disable/close_disable.png
%{_libdir}/klook/images/buttons/press/prev_press.png
%{_libdir}/klook/images/buttons/press/next_press.png
%{_libdir}/klook/images/buttons/press/gallery_press.png
%{_libdir}/klook/images/buttons/press/open_in_press.png
%{_libdir}/klook/images/buttons/press/fullscreen_press.png
%{_libdir}/klook/images/buttons/press/close_press.png
%{_libdir}/klook/translations/klook_ru.qm
/usr/bin/klook

%changelog
* Tue Feb 21 2012 abf
- The release updated by ABF

* Tue Feb 21 2012 abf
- The release updated by ABF

* Mon Feb 20 2012 abf
- The release updated by ABF

* Mon Feb 20 2012 abf
- The release updated by ABF

* Mon Feb 20 2012 abf
- The release updated by ABF

* Mon Feb 20 2012 abf
- The release updated by ABF

* Mon Feb 20 2012 abf
- The release updated by ABF

* Mon Feb 20 2012 abf
- The release updated by ABF
