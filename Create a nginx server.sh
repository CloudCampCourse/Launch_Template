# Hands-on EC2-02: Installing Nginx Web Server on Amazon Linux 2

## Purpose

This hands-on training provides students with fundamental knowledge of installing Nginx Web Server on an Amazon Linux 2 EC2 instance.

## Learning Outcomes

By the end of this training, students will be able to:

- Launch an AWS EC2 instance.
- Establish an SSH connection to the EC2 instance.
- Install Nginx Web Server on Amazon Linux 2.
- Configure Nginx to serve a simple HTML page.
- Create a bash script to run the web server.
- Automate the installation and configuration process using the `user-data` script of the EC2 instance.

## Outline

### Part 1 - Launching an Amazon Linux 2 EC2 instance and Connecting with SSH

1. Launch an Amazon Linux 2 EC2 instance with the AMI as `Amazon Linux 2`, instance type as `t2.micro`, and the default VPC security group allowing connections from anywhere and any port.

```bash
ssh -i [Your Key pair] ec2-user@[Your EC2 IP / DNS name]
```

### Part 2 - Installing and Configuring Nginx Web Server to Run a Simple Web Page

1. Update the installed packages and package cache on your instance.

```bash
sudo yum update -y
```

2. Install Nginx Web Server.

```bash
sudo amazon-linux-extras install nginx1.12
```

3. Start the Nginx Web Server.

```bash
sudo systemctl start nginx
```

4. Check from the browser with public IP/DNS.

5. Navigate to the `/usr/share/nginx/html` folder.

```bash
cd /usr/share/nginx/html
```

6. Show content of folder and change the permissions of `/usr/share/nginx/html`.

```bash
ls
sudo chmod -R 777 /usr/share/nginx/html
```

7. Remove existing `index.html`.

```bash
sudo rm index.html
```

8. Upload new `index.html` and `ryu.jpg` files with `wget` command. Explain the RAW on GitHub.

```bash
wget https://raw.githubusercontent.com/CloudCampCourse/awslessons/main/index.html
wget https://raw.githubusercontent.com/CloudCampCourse/awslessons/main/ccc.jpg
```

9. Restart the Nginx Web Server.

```bash
sudo systemctl restart nginx
```

10. Configure to start while launching.

```bash
sudo systemctl enable nginx
```

11. Check if the Web Server is working properly from the browser.

12. To add another content, change the permissions of the folder `/usr/share/nginx/html` (if you haven't before).

```bash
sudo chmod -R 777 /usr/share/nginx/html
```

13. Add another `index_2.html` file.

```bash
echo "Second Page" > /usr/share/nginx/html/index_2.html
```

14. Add "/index_2.html" at the end of the public DNS.

```bash
http://ec2-54-144-132-10.compute-1.amazonaws.com/index_2.html
```

### Part 3 - Automation of Web Server Installation through Bash Script (User data)

15. Configure an Amazon EC2 instance with AMI as `Amazon Linux 2`, instance type as `t2.micro`, default VPC security group allowing connections from anywhere and any port.

16. Configure the instance to automate web server installation with the `user-data` script.

```bash
#! /bin/bash

yum update -y
amazon-linux-extras install nginx1.12
systemctl start nginx
cd /usr/share/nginx/html
chmod -R 777 /usr/share/nginx/html
rm index.html
wget https://raw.githubusercontent.com/CloudCampCourse/awslessons/main/index.html
wget https://raw.githubusercontent.com/CloudCampCourse/awslessons/main/ccc.jpg
systemctl restart nginx
systemctl enable nginx
```

17. Review and launch the EC2 instance.

18. Once the instance is running, check if the Nginx Web Server is working from the web browser.

19. Connect to the Nginx Web Server from the terminal with the `curl` command.

```bash
curl http://ec2-3-15-183-78.us-east-2.compute.amazonaws.com
```