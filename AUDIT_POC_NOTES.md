# Audit/POC Discussion Notes: PCI-POC AWS Infrastructure (Terraform)
## Overview
This Proof of Concept (POC) demonstrates automated, secure, and auditable AWS infrastructure deployment using Terraform. The solution replaces manual resource creation with Infrastructure as Code (IaC) for repeatability, compliance, and rapid recovery.

## Key Components
- **VPC:** Used AWS default VPC and subnets for simplicity and rapid deployment.
- **Subnets:** Leverages default public subnets for ALB and EC2 instances.
- **ALB:** Internet-facing Application Load Balancer with ACM SSL certificate.
- **EC2 Instances:**
  - App instance (Linux) with user-data for package installation and secure startup.
  - MySQL instance (Linux) for database needs.
- **Security Groups:**
  - ALB: Inbound HTTPS (443) from allowlist, egress only to required destinations.
  - App: Inbound HTTP (80) from ALB, egress only to secureweb.com (by IP/CIDR).
  - DB: Inbound MySQL (3306) from App, egress can be further restricted.
- **Logging:**
  - VPC Flow Logs enabled to CloudWatch for network auditability.

## Security & Compliance
- **Least Privilege:** Security groups restrict inbound and outbound traffic to only what is required.
- **Audit Readiness:**
  - All changes are tracked in Terraform state and version control.
  - VPC Flow Logs provide network activity records.
  - All resources are tagged for traceability.
- **Automation:**
  - Infrastructure can be recreated or destroyed in minutes.
  - No manual steps required for provisioning.

## Discussion Points
* **EC2 User Data:** On startup, the instance runs a user-data script that installs a required package from example.com. If the package is not installed, the application will not start. This can also be manually applied to the EC2 instance if needed for troubleshooting or testing.

- **Alternative for Audit:**
  - If rollout is delayed, document all manual steps, export current AWS resource configurations, and enable logging on all critical resources.
  - Use AWS Config for additional resource compliance tracking.
  - Restrict inbound to allowlist, block outbound except required IPs (Security group or NACL)
  - we can also tag all resources for traceability.
  - Consider enabling ALB access logs for HTTP request auditing.
  - Store all documentation and evidence in a central, auditable location.
  - Consider deploying AWS WAF (Web Application Firewall) to protect the ALB and add an additional layer of security and audit logging for web traffic.

- **POC Limitations:**
  - Uses default VPC for speed / (for dev environment); production should use custom VPC with private/public subnets.
  - Secrets (e.g., DB passwords) should be managed with AWS Secrets Manager in production.


