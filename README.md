Created two jobs for this task

## Job-01: Provision the Mediawiki server
- 	Using GitHub action for this job
- 	Self-hosted Runner server is created
- 	It’s a Parameterized job and can perform terraform apply or destroy based on the choice

## GitHub runner server-side configuration:
- 	Using awscli, aws creds are configured
- 	Terraform and ansible packages are installed  


## Terraform role: 
- 	Using existing VPC and Subnet resource and Provision the security group
- .	Provision EC2 instance with newly created SG
- 	Terraform install python3 package on newly created EC2 instance
- .	Terraform trigger the ansible playbook
  

## Ansible role: 
- .	Install required packages
- .	Starts the mariadb service
- 	Creates the Database, username and grant privileges
- 	Download the mediawiki tar file
- 	create code directory
- 	Untar zipped code into newly created directory
- 	Create the softlink to /var/www/
- 	Change the softlink directory ownership
- 	Updating the DocumentRoot
- 	Modifying the selinux policy 
- 	Restart the httpd service
   
   


## Job-02: Deploy New tar.zip code on the mediawiki server
- 	Using github actions for CICD
- .	Provide the new mediawiki url in the build parameter option

## Ansible:
- 	Ansible will picked the newly downloaded tar.zip file
- 	Remove the old code directory
- 	Create new code directory
- 	Finds the newly downloaded code
- 	Untar the code
- 	Remove the old code softlink
- 	Create a new one 
- 	Update the ownership privileges over the softlink code
- 	Restart the httpd service
