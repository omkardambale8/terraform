---

# Auto Scaling Group with Launch Configuration – High Availability Setup

## 📌 Overview

This project demonstrates how to configure an **Auto Scaling Group (ASG)** in AWS with a **Launch Configuration** to automatically scale EC2 instances based on demand.
The setup ensures **high availability** by distributing instances across multiple Availability Zones and replacing unhealthy instances automatically.

---

## 🏗 Architecture

* **Launch Configuration** – Defines instance type, AMI, security groups, and key pairs.
* **Auto Scaling Group** – Automatically manages EC2 instances to meet desired capacity.
* **Load Balancer (Optional)** – Distributes incoming traffic evenly across instances.
* **CloudWatch Alarms** – Triggers scaling actions based on CPU utilization or other metrics.

```
       Internet
          │
   ┌──────▼──────┐
   │   ALB/NLB   │
   └──────▲──────┘
          │
   ┌──────┴─────────────┐
   │  Auto Scaling Group│
   │ (Multi-AZ)         │
   └──────▲─────────────┘
          │
     EC2 Instances
```

---

## 🔧 Steps to Implement

### 1️⃣ Create Launch Configuration

* Specify:

  * **Amazon Machine Image (AMI)** (e.g., Amazon Linux 2)
  * **Instance type** (e.g., t2.micro)
  * **Security Group** (Allow required ports like HTTP/HTTPS/SSH)
  * **Key Pair** for SSH access
* Enable detailed monitoring.

### 2️⃣ Create Auto Scaling Group

* Select the **Launch Configuration**.
* Choose **VPC and multiple subnets** (spread across different AZs for HA).
* Set:

  * **Desired capacity**: e.g., 2 instances
  * **Min size**: e.g., 1 instance
  * **Max size**: e.g., 4 instances

### 3️⃣ Configure Scaling Policies

* **Scale Out Policy**:

  * Trigger when CPU Utilization > 70% (CloudWatch Alarm).
* **Scale In Policy**:

  * Trigger when CPU Utilization < 30% for a defined period.

### 4️⃣ Attach Load Balancer (Optional)

* Create an **Application Load Balancer (ALB)** and attach it to the ASG.
* Configure health checks to ensure traffic is sent only to healthy instances.

### 5️⃣ Test the Setup

* Generate load using tools like `ab` (ApacheBench) or `stress`.
* Verify that instances scale up/down as expected.

---

## 🔐 Security Best Practices

* Restrict SSH access in the security group to trusted IP addresses only.
* Use IAM roles instead of storing AWS credentials on EC2 instances.
* Enable CloudWatch Logs for monitoring instance behavior.

---

## 📂 Repository Structure

```
.
├── terraform/              # Terraform scripts for automation
├── diagrams/               # Architecture diagrams
├── README.md               # Project documentation
└── scripts/                 # Test or helper scripts
```

---

## 🛠 Tools & Services Used

* **AWS Auto Scaling**
* **Launch Configuration**
* **EC2**
* **VPC**
* **CloudWatch**
* **Load Balancer (optional)**
* **AWS CLI / Terraform**

---
