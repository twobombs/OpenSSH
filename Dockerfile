
#Docker file for installing SSH

#Adjust line following comments to select desired edition of Server 2016
#FROM microsoft/windowsservercore:latest
FROM microsoft/windowsservercore:latest

RUN powershell Install-PackageProvider NuGet -forcebootstrap -force
RUN powershell Register-PackageSource -name chocolatey -provider nuget -location http://chocolatey.org/api/v2/ -trusted
RUN powershell Install-Package openssh -provider NuGet
RUN powershell cd "$((dir "$env:ProgramFiles\nuget\packages\openssh*\tools" |select -last 1).fullname)" ; . ".\barebonesinstaller.ps1" -SSHServerFeature
RUN powershell choco -y install -y systernals 
RUN powershell choco -y install -y VcXsrv
RUN powershell choco -y install -y mc

EXPOSE 22/tcp

#docker build . -t yourdockerid/nanoserverwithssh
#docker run -d -p 127.0.0.1:22:5000 --name nanowithsshd -t yourdockerid/nanoserverwithssh
