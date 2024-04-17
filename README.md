# Apps CoI: Ansible Lunch and Learn
This repository contains the code needed to setup the Ansible L&L demo on your local machine. This uses Docker containers to simulate a small environemnt with hosts that Ansible scripts can be run against. Included is the scripting framework needed to build this environment and a couple of Ansibe playbooks for demonstration purposes.

### Contents

- [Prerequisites](#prerequisites)
    - [Mandatory](#mandatory)
    - [Recommended](#recommended)
- [Getting Started](#getting-started)
    - [Navigating the repository](#navigating-the-repository)
    - [Building the environment](#building-the-environment)
    - [Developing on the environment](#developing-on-the-environment)
- [About](#about)

## Prerequisites
To deploy the environent and get started with developing Ansible automations, there are some recommended and mandatory dependancies that must be installed on your development machine prior to starting the L&L.

### Mandatory
- **Docker** *Due to licensing restrictions, Docker Desktop cannot be used, only Docker CLI.* This can be installed [here](https://docs.docker.com/engine/install/), If you are using Windows, you will need to [install docker in WSL](https://dataedo.com/docs/installing-docker-on-windows-via-wsl) (the specific distribution you choose for WSL doesn't matter). Ensure docker compose is also installed, the below command should return the currently installed version.
    ```shell
    docker-compose --version
    ```
- **Make** This repository uses Makefiles to simplify setup. You can install Make via your linux distributions package manager. If you're running windows, it might be easier to install Make in WSL.

### Recommended
- **Visual Studio Code** is the recommended IDE for writing Ansible YAML, it can be downloaded [here](https://code.visualstudio.com/download).
- **Ansible Extension** for Visual Studio Code linting. This can be found [here](https://marketplace.visualstudio.com/items?itemName=redhat.ansible).

## Getting Started

### Navigating the repository
The project is laid out as follows:
- **ansible/**<br/>
    This directory will be your primary working directory for developing Ansible automations. Anything you make here will be mapped to the `/ansible` directory inside the `ll-ansible-host` container which will run the code. A couple of demo playbooks have been included.
    - **inventory.yaml**<br/>
        This Ansible inventory file is pre-populated with each of the three host nodes and the details required to SSH to each of them
    - **Makefile**<br/>
        This makefile includes some targets to simplify the running of the included demo playbooks. This will be executed from inside the docker container.
- **docker/**<br/>
    This directory contains all of the setup scripts needed to define the environment. You should not need to modify any files in this directory.
- **Makefile**<br/>
    This makefile includes targets used to simplify the management of the environment. This should be run from the host machine.

### Building the environment
To manage the environment, there are two commands to be run from the host machine:
- Create the environment.
    ```shell
    make env-up
    ```
- Destroy the environment. *Note that destroying the environment will not delete any scripts stored in the `/ansible` directory*
    ```shell
    make env-down
    ```

### Developing on the environment
The environment consists of the below containers:
- ll-ansible-host
- ll-host-1
- ll-host-2
- ll-host-3

All nodes are running the CentOS-Stream-9 image. The Ansible host will act as a jump host and be the execution node for all your scripts, you will enter this container to do your development. The other hosts are there to perform automations against. Each host shares the same public/ private key pair for SSH authentication against the root user for simplicity. Included at `ansible/inventory.yaml` is an inventory file containing these three hosts that will manage the SSH authentication for Ansible. If you need to manually SSH into each of these hosts, you should be able to do so from the Ansible host by using the command `ssh root@ll-host-1` for example.

Assuming the environment is standing, the below workflow should be followed to run the demos or develop on the environment.
1. Enter the shell for the Ansible host. This will take you to the `/ansible` directory inside the container which mounts to the `ansible/` directory in this repository on your docker host.
    ```shell
    make env-enter
    ```
1. Run the hello world demo.
    ```shell
    make demo
    ```
1. Run the get-facts demo. You will see a new folder created in the ansible directory called `artefacts/`, inside will be a couple of JSON files containing the complete `ansible_facts` object for each host.
    ```shell
    make get-facts
    ```
1. Exit the Ansible host to return to your docker host's shell.
    ```shell
    exit
    ```
When making your own automations, you can use Visual Studio Code to create and edit your playbooks inside the `ansible/` directory then enter the Ansible host to run them against the other nodes.

## About

- **Author**: Callum Williamson
- **Contact**: callum.williamson@fujitsu.co.uk
