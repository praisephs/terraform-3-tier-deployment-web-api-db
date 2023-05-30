

## Project Case Study: Provisioning Linux Virtual Machines(Web, API and DB) in Azure with Terraform for a 3-Tier Infrastructure Setup

## Project Overview: 

The goal of this project is to provision a 3-tier infrastructure setup on Azure using Terraform. The infrastructure will consist of three virtual machines (Web, API, and Database) that will serve as a testing environment for the development team.

The project requires the deployment of all necessary components,including networking resources. 

The primary objective is to ensure that the deployment meets network security requirements by exposing only the required workload to the internet and blocking unauthorized traffic to private resources.

## Deliverables: 

Architecture diagram showcasing the environment setup
Terraform configuration files to provision the infrastructure
README.md file explaining the Terraform configuration and providing instructions for deploying the infrastructure
Screenshots of the deployed Azure resources, including the virtual machines, networking resources, security groups and public-IP

Architecture Diagram:

![Architecture Diagram](https://github.com/praisephs/basic_model/assets/129758959/2ca4c5f1-9c55-49c1-9f6c-4e9cd2be4128)



## Project Steps:

- Created an architecture diagram to visualize the infrastructure setup.
- Defined and configured the Azure provider in the Terraform configuration.
- Created a resource group to contain all the Azure resources.
- Provisioned three virtual networks (Web-subnet=10.0.0.0/24, API-subnet=10.0.1.0/24, DB-subnet=10.0.2.0/24) within the resource group, each with its respective subnet.
- Deployed three virtual machines (Web-VM, API-VM, DB-VM) within their respective subnets, using the desired Linux image and configuring necessary settings.
- Created a virtual netowrk, dev-vnet=10.0.0.0/16
- Created a public IP address for the Web-VM to enable access from the internet.
- Configured network security groups (NSGs) for each subnet to control inbound and outbound traffic.
- Associated appropriate NSG rules with each NSG to enforce network security requirements.
- Documented the Terraform configuration in the README.md file, providing instructions for deploying the infrastructure.
- Used Azure CLI commands to retrieve information about the deployed resources.
- Captured screenshots of the Azure portal showing the provisioned resources and the screenshots to the README.md file for visual reference
- Ensured that the Terraform configuration follows best practices and is structured in a modular and reusable manner.
- Configured appropriate security measures for the virtual machines, such as SSH key-based authentication and secure connections.
- Used variables and count parameters in the Terraform configuration to make it flexible and customizable.
- Continuously tested and validated the Terraform configuration to ensure reliable and consistent deployments.

## NSG RULES
1. Web-VM
(a) Allow inbound HTTP traffic from Internet to web-vm on port 80
(b) Allow inbound SSH traffic from Internet to web-vm on port 22 
(c) Allow outbound HTTP traffif from web-vm to Internet on port 80

2. API-VM
(a) Allow HTTP inbound traffic from web-vm to API-vm on port 80
(b) Allow SSH from web-vm to API on port 22
(c) Allow outbound traffic from API-vm to web-vm
(d) Deny inbound HTTP traffic from Internet to API-vm on port 80

3. DB-VM
(a) Allow inbound traffic from API-vm to DB-vm on port 22
(b) Allow outbound traffic from API-vm to DB-vm on port 22
(c) Deny inbound HTTP traffic from Internet to DB-vm on port 80
(d) Deny outbound HTTP traffic from DB-vm to Internet on port 80
(e) Deny inbound and outbound traffic from web-vm over the DB-vm on port 22
