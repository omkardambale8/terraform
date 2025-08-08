---

# SNS Notifications for EC2 Events – Integrated with CloudWatch

## 📌 Overview

This project demonstrates how to **set up Amazon SNS (Simple Notification Service) to receive alerts for EC2 events** by integrating with **Amazon CloudWatch**.
With this setup, you can get real-time notifications (via email/SMS) for events like instance state changes, health status updates, or performance metric breaches.

---

## 🏗 Architecture

* **EC2 Instance** – The resource being monitored.
* **CloudWatch Metrics/Events** – Detects state changes or threshold breaches.
* **SNS Topic** – Delivers notifications to subscribed endpoints (Email, SMS, Lambda).
* **CloudWatch Alarm / EventBridge Rule** – Triggers SNS notifications when conditions are met.

```
EC2 Instance 
   │
   ▼
CloudWatch Metrics & Events
   │
   ▼
CloudWatch Alarm / EventBridge Rule
   │
   ▼
SNS Topic → Email / SMS / Lambda
```

---

## 🔧 Steps to Implement

### 1️⃣ Create an SNS Topic

* Navigate to **SNS → Topics → Create topic**.
* Name it (e.g., `EC2-Notifications`) and select **Standard** type.
* Add a display name for SMS (optional).

### 2️⃣ Subscribe to the Topic

* Choose **Create subscription**.
* Select **Protocol**: Email or SMS.
* Enter the endpoint (email address or phone number).
* Confirm subscription from your email/SMS.

### 3️⃣ Create a CloudWatch Alarm

* Go to **CloudWatch → Alarms → Create alarm**.
* Choose a metric for your EC2 instance (e.g., CPUUtilization, StatusCheckFailed).
* Set threshold (e.g., CPUUtilization > 80%).
* For the **Actions** section, select **Send notification to SNS topic** created earlier.

### 4️⃣ Create an EC2 State Change Rule (Optional)

* Navigate to **EventBridge → Rules → Create rule**.
* Event pattern: EC2 Instance State-change Notification.
* Target: SNS topic.

### 5️⃣ Test the Setup

* Stop/start the EC2 instance or generate load to trigger the alarm.
* Verify that you receive SNS notifications.

---

## 🔐 Security Best Practices

* Use IAM policies to restrict who can publish to the SNS topic.
* Do not expose personal phone numbers or emails in public code repositories.
* Enable CloudWatch Logs for auditing notifications.

---

## 📂 Repository Structure

```
.
├── terraform/              # Terraform automation scripts (optional)
├── diagrams/               # Architecture diagrams
├── README.md               # Project documentation
└── scripts/                 # Test/load generation scripts
```

---

## 🛠 Tools & Services Used

* **Amazon SNS**
* **Amazon EC2**
* **Amazon CloudWatch**
* **Amazon EventBridge**
* **AWS CLI / Terraform**


If you want, I can **merge this, the VPC Peering, and Auto Scaling README files into one "AWS Cloud Projects Portfolio README"** with a consistent style and project index so your GitHub looks like a complete showcase. That would make it way more impressive to recruiters.
