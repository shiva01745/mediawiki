Created two jobs for this task

1. Job-01: Provision the Mediawiki server
a.	Using GitHub action for this job
b.	Self-hosted Runner server is created
c.	It’s a Parameterized job and can perform terraform apply or destroy based on the choice

2. GitHub runner server-side configuration:
a.	Using awscli, aws creds are configured
b.	Terraform and ansible packages are installed  


3. Terraform role: 
a.	Using existing VPC and Subnet resource and Provision the security group
b.	Provision EC2 instance with newly created SG
c.	Terraform install python3 package on newly created EC2 instance
d.	Terraform trigger the ansible playbook
  

4. Ansible role: 
a.	Install required packages
b.	Starts the mariadb service
c.	Creates the Database, username and grant privileges
d.	Download the mediawiki tar file
e.	create code directory
f.	Untar zipped code into newly created directory
g.	Create the softlink to /var/www/
h.	Change the softlink directory ownership
i.	Updating the DocumentRoot
j.	Modifying the selinux policy 
k.	Restart the httpd service
   
   


1. Job-02: Deploy New tar.zip code on the mediawiki server
a.	Using github actions for CICD
b.	Provide the new mediawiki url in the build parameter option

2. Ansible:
a.	Ansible will picked the newly downloaded tar.zip file
b.	Remove the old code directory
c.	Create new code directory
d.	Finds the newly downloaded code
e.	Untar the code
f.	Remove the old code softlink
g.	Create a new one 
h.	Update the ownership privileges over the softlink code
i.	Restart the httpd service
