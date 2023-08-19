# Dockerfile for a PowerShell container with Posh-SSH module
# Use the official PowerShell LTS image as the base
FROM mcr.microsoft.com/powershell:lts
LABEL maintainer="Guilherme Sousa <https://www.linkedin.com/in/guilherme-sousa-rodrigues/>"

# Set the shell to use /bin/bash as the default shell
SHELL ["/bin/bash", "-c"]

# Create a directory named /app/temp and install the Posh-SSH module using PowerShell
RUN mkdir -p /app/temp && \
    pwsh -Command "Install-Module -Name Posh-SSH -Force" && \
    pwsh -Command "Import-Module Posh-SSH"
#    && wget https://raw.githubusercontent.com/gui-sousa/docker-powershell-poshSSh/main/send-sftp.ps1
    

# Create named volumes for /app/origem and /app/processados
#COPY send-sftp.ps1 /app
VOLUME /app/send-sftp.ps1
VOLUME /app/origem
VOLUME /app/processados

# Set the entry point to start PowerShell when a container is run
ENTRYPOINT ["pwsh", "/app/send-sftp.ps1"]
