# Multi EC2 Instance + Bootstrap

### Description

The main.tf demonstrates how to provision multiple EC2 instances from a list of hostnames, and how to bootstrap the hosts once they are live. 

This code is based on Terraform version 0.12.

It features use of new functions such a "templatefile()" and "for\_each".
 
<img src="http://ascetism.com/terraform_ec2_bootstrap.jpg" alt="AWS thingy">
