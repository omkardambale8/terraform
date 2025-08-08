---

# Remote State Management with S3 and DynamoDB Locking

## 📌 Overview

This project demonstrates how to configure **Terraform remote state storage** using **Amazon S3** for centralized state management, and **DynamoDB** for state locking to prevent concurrent modifications.
This setup enables **collaboration**, **versioning**, and **safe state updates** in multi-developer or CI/CD environments.

---

## 🏗 Architecture

* **Amazon S3** – Stores the Terraform state file (`terraform.tfstate`) securely.
* **DynamoDB Table** – Provides state locking and consistency checks.
* **Terraform Backend Configuration** – Points to the S3 bucket and DynamoDB table.

```
Terraform CLI 
    │
    ▼
S3 Bucket (State Storage)  ←→  DynamoDB Table (State Locking)
```

---

## 🔧 Steps to Implement

### 1️⃣ Create S3 Bucket for State Storage

```bash
aws s3api create-bucket --bucket my-terraform-state-bucket --region us-east-1
```

* Enable **versioning** to keep a history of state changes:

```bash
aws s3api put-bucket-versioning --bucket my-terraform-state-bucket --versioning-configuration Status=Enabled
```

### 2️⃣ Create DynamoDB Table for State Locking

```bash
aws dynamodb create-table \
  --table-name terraform-lock-table \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
```

### 3️⃣ Configure Terraform Backend

In your `main.tf` (or separate `backend.tf` file):

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "env/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
```

### 4️⃣ Initialize Terraform with Backend

```bash
terraform init
```

### 5️⃣ Test Locking

* Run `terraform apply` in one terminal and try `terraform apply` in another.
* The second operation should be blocked until the first completes.

---

## 🔐 Security Best Practices

* Enable **server-side encryption** (SSE) on the S3 bucket.
* Restrict S3 bucket access with IAM policies.
* Enable CloudTrail logging for S3 and DynamoDB to audit changes.
* Use separate state files for each environment (dev, staging, prod).

---

## 📂 Repository Structure

```
.
├── terraform/              # Terraform configurations
├── backend.tf               # Backend configuration
├── README.md                # Project documentation
└── variables.tf             # Variable definitions
```

---

## 🛠 Tools & Services Used

* **Terraform**
* **Amazon S3**
* **Amazon DynamoDB**
* **AWS CLI**

---
