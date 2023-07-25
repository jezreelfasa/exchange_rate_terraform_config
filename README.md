# exchange_rate_terraform_config
terraform configuration for the EC2 instance


#Tools used for this project
In building this project, the below tools were used.
. TERRAFORM
. PYTHON3
. AWS CLI
. AWS SNS
. IAM
. AWS S3  
. EXCHANGE RATE API
. Boto3


STEPS TAKEN IN BUILDING THE PROJECT
1. Creation of EC2 instance, VPC and security group
Firstly, terraform was used to create the EC2 instance and all other resources needed to run the instance, such as security groups to allow traffic for HTTPS, HTTP, and SSH. The ami id for the instance was set as copied from the aws ami, instance type set to t2.micro and the availability zone set to us-east-1.
Also, vpc, subnet for the vpc, availability zone set for the subnet. AWS internet gateway, network interface was also created as well as route tables and route table associations and a private IP was created also, public IP was set to be auto assigned, using the aws_eip. userdata was also created which installs apache2 in the EC2 Ubuntu server once it is created. after all resources needed has been harcoded, next was to run the terraform plan to check for potential errors and see all rsources that will be added.

2. Creation of AWS SNS topic
After the EC2 instance creation, the next thing creatred was the SNS topic that would send notification after the cront job runs the python script at the stiupulated time set. Access policy was created fro the SNS topic where the topic arn was declared along with the s3 bucket the triggered messages would be sent to. A subscritpion was also created and email services selected then the email address to receive the notifications.

3. Creation of directory to house python script
Next, in the EC2 instance, a python-json-env directory was created, inside this directory, the python script that sends request to the exchange rate api to get exchange rates as it fluctuates every hour is created. 

4. Creation of cron job
   Next, cronjob was created to run the python script every 1 hour and sen the out put in json format into the s3 bucket and trigger the sns topic notification to send notification to the email address.


CHALLENGES 
Tags
One of the challenges faced in this project was with tags. tags for resources, i.e, vpc was not initiall set as line of strings which triggered errors when terraform plan was run.

Availability zone
The availability zone for the instance was set to us-east-1 without an alphabet, ie., 1a,b or c. It took a few minutes to discover this and the error response was rectified. 

EC2
The EC2 instance did not create by terraform due to no permission granted to the IAM user. It was later rectified.

Private IP
THe private ip was not mapped to the network intrerface, when I checked, there was conflict of numbers. The IP on the private IP was set at "10.0.1.55", while on the "aws_eip" "one", another Ip address was associated "10.0.1.50". The later was changed so the former would be used. "10.0.1.55" was later used and the error was resolved.
