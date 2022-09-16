# assignment2-cloudfront-s3-website-hosting

Q--> Ansible + Terraform - Write a terraform code to create a VPC and its components, create an EC2 instance and install Jenkins on the EC2 instance using Ansible, run ansible command within/from terraform itself. Try to print the jenkins default password as an output.


I have first created a vpc and lauched a ec2 instance for jenkins .
I have also created a ec2 to deploy our ansible from which we will install jenkins to our frist ec2 but the best practive would be to use ansible from our local machine which will reduce cost of our one ec2.

#steps this terraform scipt will do:

1) deploy a entire vpc with pulic and private subnet.
2) Two ec2 in public subnet one for ansible and one for ansible host where we will install our jenkins.
3) Then we have a ssh.tf file which will ssh in ansible machine and copy files from our local to ansible which will change inventory file and a playbook to    install jenkins which will run on host defined in inventory file.
4) At the end the file will install ansible and print jenkins password for us as output from the register used in ansible playbook.

#security measures:
1) we can create our ec2 in private subnet if required.
