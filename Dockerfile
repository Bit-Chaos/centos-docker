# CentOS 8
FROM centos:8

ARG USER_NAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

COPY microsoft.repo /etc/yum.repos.d/
COPY docker-ce.repo /etc/yum.repos.d/

# configure the software-stack (as root)
RUN dnf -y install dotnet-sdk-3.1
RUN dnf -y install gdb
RUN dnf -y install gcc-c++
RUN dnf -y install cmake
RUN dnf -y install make
RUN dnf -y install git
RUN dnf -y install python3
RUN dnf -y install python3-pip
RUN dnf -y install tmux
RUN dnf -y install nmap
RUN dnf -y install vim-minimal
RUN dnf -y install sudo which
RUN dnf -y install net-tools
RUN dnf -y install docker
RUN dnf -y install https://github.com/PowerShell/PowerShell/releases/download/v7.0.3/powershell-7.0.3-1.centos.8.x86_64.rpm

RUN groupadd --gid $USER_GID $USER_NAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USER_NAME \
    && echo $USER_NAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER_NAME \
    && chmod 0440 /etc/sudoers.d/$USER_NAME

RUN pip3 install conan
RUN pip3 install conan_package_tools

USER $USER_NAME
WORKDIR /home/$USER_NAME

ENV DOTNET_CLI_TELEMETRY_OPTOUT 1
RUN dotnet tool install --global GitVersion.Tool --version 5.3.7 --add-source https://www.nuget.org/api/v2/
RUN ln -s /home/$USER_NAME/.dotnet/tools/dotnet-gitversion /home/$USER_NAME/.dotnet/tools/gitversion
RUN mkdir -p /home/$USER_NAME/bin
RUN ln -s /usr/bin/pip3 /home/$USER_NAME/bin/pip

