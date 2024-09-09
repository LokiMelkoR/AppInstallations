TeamsBootstrapper is a lightweight online installer with a headless command-line interface. It allows admins to provision (install) the app for all users on a given target computer.

When teamsbootstrapper.exe is run on a computer:

The installer downloads the latest Teams MSIX package from Microsoft
The installer installs the Teams application for all users on the computer, and any users who may be added afterwards.
Modifies the registry to allow Teams to work with Office and other computer applications.
Displays success or failure message on the command line

Requirements : 

Requirement	Version/Description

Windows 10 version 10.0.19041 or higher (excluding Windows 10 LTSC for Teams desktop app)

Classic Teams app	Version 1.6.00.4472 or later to see the Try the new Teams toggle.
Important: Classic Teams is only a requirement if you want users to be able to switch between classic Teams and new Teams. This prerequisite is optional if you only want your users to see the new Teams client.

Microsoft 365 Apps or Office LTSC 2021 Learn more: Office versions and connectivity to Microsoft 365 services

Settings	Turn on the "Show Notification Banners" setting in System > Notifications > Microsoft Teams to receive Teams Notifications.

Webview2	Update to the most current version. Learn more: Enterprise management of WebView2 Runtimes

Delivery optimization (DO)	DO powers Teams automatic updates, which are required as part of the Servicing Agreement.

Overview: What is Delivery Optimization?



Following is a method to use a scripted installation with the Bootstrapper. You can also do it with M365 apps package deployment, but there is a risk that the Classic Teams will remain installed. This is because MS checks your entire tenant if migration is done to all users. If only Old users are migrated only MS will automatically uninstall Classic Teams. And we know how eager users can be right? So alternatively you can do this via a custom win32app with a PowerShell script that first make sure to uninstall the Classic Teams and then install the New Teams with the bootstrapper method. 


First write an installer script and build an Intunewin package with the files:

Intune-NewTeamsInstaller.ps1
teamsbootstrapper.exe

![image](https://github.com/user-attachments/assets/4caac708-bdba-4845-acad-3554995096fe)
