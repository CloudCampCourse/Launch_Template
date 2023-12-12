# Hands-on EC2-03: Creating an Instance with Launch Template and Versioning

## Purpose

This hands-on training aims to familiarize students with the creation of Launch Templates on the AWS Console, incorporating `user data` and understanding the process of versioning Launch Templates.

## Learning Outcomes

By the end of this hands-on training, students will be able to:

- Create and configure Launch Templates.
- Modify Launch Templates using versioning.

## Outline

- Part 1 - Creating Launch Templates
  - Step 1: Create Security Group
  - Step 2: Create Launch Template
  - Step 3: Create an Instance with Launch Template

- Part 2 - Modifying Launch Template
  - Step 1: Launch Template Version 2
  - Step 2: Launch Template Version 3

## Part 1 - Creating Launch Templates

### Step 1: Create Security Group

1. Create a Security Group named `Launch_Temp_Sec_group` with rules:
   - SSH 22, HTTP 80 → anywhere(0.0.0.0/0)

### STEP 2: Create Launch Template

2. Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.

3. Navigate to `INSTANCES` on the left pane, choose `Launch Templates`.

4. Click on `Create launch template`.

5. Enter a name and description for the initial version of the launch template:
   - Name: MyCloudCampTemplate
   - Template version description: Origin

6. Autoscaling Guidance: Keep it as default.

7. Template Tags: Keep it as is.

8. Source Template: Keep it as is.

9. Amazon Machine Image (AMI):
   - Amazon Linux 2 AMI (HVM), SSD Volume Type
   - ami-02e136e904f3da870

10. Instance Type: t2.micro

11. Key pair: Select your key pair (pem key) created before, e.g., CloudCamp.pem.

12. Network settings: Network Platform - Virtual Private Cloud (VPC)

13. Security groups: Security Group Name - Launch_Temp_Sec_group

14. Storage (volumes): Keep it as is.

15. Resource tags:
   - Key: Name
   - Value: Webserver-Origin
   - Resource type: Instance

16. Network interfaces: Keep it as is.

17. Advance details: Keep it as is.

### Step 3: Create an Instance with Launch Template

18. Go to `Launch Template` Menu.

19. Select `MyCloudCampTemplate` → `Actions` → `Launch Instance from Template`.

20. Enter the number of instances as `1`.

21. Keep the remaining settings as is and click `Launch instance from template`.

22. Go to EC2 Instance menu and display the created instance.

## Part 2 - Modifying Launch Template

### Step 1: Launch Template Version 2

23. Go to Launch Template menu on the left pane.

24. Select the template named `MyCloudCampTemplate` → `Actions` → `Modify template (Create New Version)`.

25. Template version description: V1 nginx.

26. Key pair: Select your .pem file name.

27. Resource tags:
   - Key: Name
   - Value: Nginx-Webserver-V2
   - Resource type: Instance

28. Go to `Advance Details` and add the script into the `user data` field.

```bash
#!/bin/bash

yum update -y
amazon-linux-extras install nginx1.12
systemctl enable nginx
systemctl start nginx
```

29. Go to `Launch Template` Menu and click on `MyCloudCampTemplate`.

30. Select version `2` from the `Versions` tab.

31. Select `Actions` → `Launch instance from template`.

32. Number of Instances: 1.

33. Click the 'Launch Instance from template' button.

34. Go to `Instance Menu` and show the recently created EC2 instance.

### Step 2: Launch Template Version 3

35. Go to `Launch Template` menu on the left pane.

36. Select the template named `MyCloudCampTemplate` → `Actions` → 'Modify template (Create New Version)'.

37. Template version description: V3 nginx.

38. Key pair: Select your .pem file name.

39. Resource tags:
   - Key: Name
   - Value: Webserver-V3
   - Resource type: Instance

40. Go to `Advance Details` and add the script into the `user data` field.

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

41. Go to `Launch Template` Menu and click on `MyCloudCampTemplate`.

42. Select version `3` from the `Versions` tab.

43. Select `Actions` → `Launch instance from template`.

44. Number of Instances: 1.

45. Click the `Launch Instance from template` button.

46. Go to `Instance Menu` and show the recently created EC2 instance.

47. Copy EC2's `Public IP`, paste it in a browser, and show the `nginx` webpage with the `ccc` image.