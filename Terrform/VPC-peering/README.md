---

# VPC Peering Between Two VPCs – Secure Configuration

## 📌 Overview

This project demonstrates how to configure **secure VPC Peering** between two AWS VPCs, enabling private communication without traversing the public internet.
The setup ensures **controlled access** using route tables, security groups, and network ACLs.

---

## 🏗 Architecture

* **VPC-A** (Requester) – Primary VPC where application servers reside.
* **VPC-B** (Accepter) – Secondary VPC hosting database services.
* **VPC Peering Connection** – Enables private IP communication between VPCs.
* **Security Controls** – Security groups and NACL rules configured to allow only necessary traffic.

```
VPC-A (10.0.0.0/16)  <---- Peering ---->  VPC-B (192.168.0.0/16)
```

---

## 🔧 Steps to Implement

### 1️⃣ Create VPCs

* **VPC-A CIDR**: `10.0.0.0/16`
* **VPC-B CIDR**: `192.168.0.0/16`
* Create subnets, route tables, and internet gateways (if needed for testing).

### 2️⃣ Create VPC Peering Connection

* Navigate to **VPC Console → Peering Connections → Create**.
* Select **Requester VPC** (VPC-A) and **Accepter VPC** (VPC-B).
* Accept the peering request from VPC-B.

### 3️⃣ Update Route Tables

* In VPC-A route table, add a route to `192.168.0.0/16` via the peering connection.
* In VPC-B route table, add a route to `10.0.0.0/16` via the peering connection.

### 4️⃣ Configure Security Groups

* Allow inbound/outbound traffic only for required ports (e.g., `TCP 3306` for MySQL, `TCP 22` for SSH).
* Restrict access to specific private IP ranges.

### 5️⃣ Configure Network ACLs (Optional for extra security)

* Allow specific CIDRs between the two VPCs.
* Deny all unnecessary traffic.

### 6️⃣ Test Connectivity

* Launch EC2 instances in each VPC.
* Test communication using private IPs:

  ```bash
  ping 192.168.x.x
  ```

---

## 🔐 Security Best Practices

* Avoid overly permissive `0.0.0.0/0` rules.
* Use least privilege principle in security group rules.
* Monitor VPC flow logs for any suspicious activity.
* Tag resources for better management.

---

## 📂 Repository Structure

```
.
├── terraform/              # Terraform IaC scripts (if applicable)
├── diagrams/               # Network diagrams
├── README.md                # Project documentation
└── scripts/                 # Test or helper scripts
```

---

## 🛠 Tools & Services Used

* **AWS VPC**
* **VPC Peering**
* **EC2**
* **Security Groups**
* **Network ACLs**
* **AWS CLI / Terraform**

---

## 📜 License

This project is licensed under the MIT License – feel free to use and modify.

---

If you want, I can also add a **network diagram** in the `README.md` so it’s more visually appealing and recruiters/interviewers can instantly understand the architecture. That will make your GitHub project stand out.

