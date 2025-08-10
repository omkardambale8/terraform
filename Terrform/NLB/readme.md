---

# AWS Network Load Balancer (NLB) with Terraform

## 📌 Project Overview

This project demonstrates the design and deployment of an **AWS Network Load Balancer (NLB)** using **Terraform**.
The NLB distributes traffic across multiple **EC2 instances** within a custom **VPC**, ensuring **high availability** and **fault tolerance**.

Infrastructure is fully automated using **Infrastructure as Code (IaC)** principles, allowing quick, repeatable, and scalable deployments.

---

## 🚀 Features

* **Custom VPC** with public subnets across multiple Availability Zones.
* **Network Load Balancer** to distribute traffic evenly across EC2 instances.
* **EC2 Instances** running Nginx web servers.
* **Auto Scaling Group** to automatically adjust capacity based on demand.
* **Security Groups** allowing only specific CIDR ranges for enhanced security.
* Fully automated deployment using **Terraform**.

---

## 🛠 Architecture Diagram

```
Internet
   │
   ▼
[ Network Load Balancer ]
   │           │
   ▼           ▼
EC2 Instance  EC2 Instance
( AZ1 )       ( AZ2 )
   │
Custom VPC
```

---

## 📂 Project Structure

```
.
├── main.tf          # Main Terraform configuration
├── variables.tf     # Input variables
├── outputs.tf       # Output values (e.g., NLB DNS name)
├── provider.tf      # AWS provider configuration
├── userdata.sh      # EC2 initialization script (Nginx setup)
└── README.md        # Project documentation
```

---

## ⚙️ Prerequisites

* **AWS Account** with proper IAM permissions
* **Terraform** installed (v1.5+ recommended)
* **AWS CLI** configured with credentials
* Basic understanding of AWS Networking & Terraform

---

## 📋 Deployment Steps

1. **Clone this repository**

   ```bash
   git clone https://github.com/yourusername/aws-nlb-terraform.git
   cd aws-nlb-terraform
   ```

2. **Initialize Terraform**

   ```bash
   terraform init
   ```

3. **Validate configuration**

   ```bash
   terraform validate
   ```

4. **Deploy the infrastructure**

   ```bash
   terraform apply -auto-approve
   ```

5. **Test the NLB**

   * Get the NLB DNS from Terraform output:

     ```bash
     terraform output nlb_dns_name
     ```
   * Open the DNS in a browser or use `curl`:

     ```bash
     curl http://<NLB_DNS_NAME>
     ```

---

## 🧹 Cleanup

To avoid ongoing AWS charges, destroy the resources:

```bash
terraform destroy -auto-approve
```

---

## 📈 Key Outcomes

* Automated NLB + EC2 + Auto Scaling deployment in under 5 minutes.
* Highly available setup across multiple AZs.
* Scalable architecture capable of handling variable workloads.

---

## 📜 License

This project is licensed under the MIT License.

---


Do you want me to prepare that Terraform code?
