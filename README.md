# Docker PWS-POSH-SSH

<a name="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project
This document outlines the technical approach to automate secure file transfers via SFTP (SSH File Transfer Protocol) using Docker.

### Overall Operation:
The solution involves a combination of a Powershell script for managing the transfer and a Docker image containing the necessary infrastructure. The script handles copying, compressing, and sending files, while the Docker image provides the environment to execute the script in an isolated and repeatable manner.

# Script Operation: 
The Powershell script is responsible for performing the following steps:

#### Timestamp: 
Stores a timestamp to ensure unique identification of compressed files, allowing for multiple simultaneous transfers.

#### Variable Declarations: 
Defines variables to store information such as credentials for accessing the SFTP server, source and destination directories, and other required parameters.

#### File Copying: 
Copies files from the source directory (previously mapped) to a temporary folder within the Docker container. This aims to avoid copy errors and permission issues, especially in Windows Server environments.

#### Zip Compression: 
Utilizes the Powershell Compress-Archive module to compress the copied files. The timestamp is used in the compressed file's name to ensure uniqueness.

#### SFTP Sending: 
The compressed file is sent to the "Processed" folder, which was previously mapped, enabling backup copies to be maintained on the destination server.

# Docker Image Operation:
The utilized Docker image contains a Powershell distribution on top of a Linux base. The image's operation is described below:

#### Powershell Base: 
The image is built upon the latest version of Powershell, providing a consistent environment for executing the script.

#### Storage Directories: 
Two main directories are created within the container - "App" and "Temp". "App" is where files will be mapped, compressed, and sent, while "Temp" stores intermediate files generated during the process.

#### Mapped Volumes: 
Directories are created as volumes, allowing source and destination directories to be mapped during container execution. The script, containing settings and steps, is also copied into the container.

#### Entrypoint: 
The image is finalized with an ENTRYPOINT that invokes Powershell and executes the sending script. This automates the file sending process.

#### Running the Docker Container:
To execute the Docker container, follow these steps:

Define the source and destination folders (they can be mapped on the network).

Point to the location where the script has been placed, customized with destination information and access credentials.

Execute the following command:

```sh
docker run -v ./your_processed_folder:/app/processados -v ./your_source_folder:/app/origem -v ./send-sftp.ps1:/app/send-sftp.ps1 –d guisousa/pwsh-posh-ssh:0.5
```
<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

* [![Poweshell][Powershell]][Angular-url]
* [![Docker][Docker]][Angular-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
### Prerequisites

* Pull Docker Image
* Define your folders for volumes
* Customize the send-sftp script with the desired address and credentials for the connection.

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/github_username/repo_name.git
   ```
2. Run Container
   ```sh
   docker run -v ./your_processed_folder:/app/processados -v ./your_source_folder:/app/origem -v ./send-sftp.ps1:/app/send-sftp.ps1 –d guisousa/pwsh-posh-ssh:0.5
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- USAGE EXAMPLES -->
## Usage

_For more examples, please refer to the [Documentation](https://medium.com/@gui_sousa/adfs-na-nuvem-com-terraform-packer-ansible-a9a0f077baae)_

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- LICENSE -->
## License

Distributed under the MIT License. See `license.md` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Gui Sousa - [@Guira_kun](https://twitter.com/Guira_kun)

Project Link: [https://github.com/github_username/repo_name](https://github.com/gui-sousa/Adfs-Packer-Terraform)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* []()BWG PORR@!!!

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/github_username/repo_name.svg?style=for-the-badge
[contributors-url]: https://github.com/github_username/repo_name/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/github_username/repo_name.svg?style=for-the-badge
[forks-url]: https://github.com/github_username/repo_name/network/members
[stars-shield]: https://img.shields.io/github/stars/github_username/repo_name.svg?style=for-the-badge
[stars-url]: https://github.com/github_username/repo_name/stargazers
[issues-shield]: https://img.shields.io/github/issues/github_username/repo_name.svg?style=for-the-badge
[issues-url]: https://github.com/github_username/repo_name/issues
[license-shield]: https://img.shields.io/github/license/github_username/repo_name.svg?style=for-the-badge
[license-url]: https://github.com/github_username/repo_name/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username
[product-screenshot]: images/screenshot.png
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[Terraform]: https://img.shields.io/badge/Terraform-20232A?style=for-the-badge&logo=terraform&logoColor=7B42BC
[Packer]: https://img.shields.io/badge/packer-20232A?style=for-the-badge&logo=packer&logoColor=02A8EF
[Ansible]: https://img.shields.io/badge/Ansible-20232A?style=for-the-badge&logo=ansible&logoColor=EE0000
[Powershell]: https://img.shields.io/badge/Powershell-20232A?style=for-the-badge&logo=powershell&logoColor=5391FE
[React-url]: https://reactjs.org/
[Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[Vue-url]: https://vuejs.org/
[Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[Angular-url]: https://angular.io/
[Svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[Svelte-url]: https://svelte.dev/
[Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[Laravel-url]: https://laravel.com
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com 
[Docker]: https://img.shields.io/badge/Docker-20232A?style=for-the-badge&logo=docker
