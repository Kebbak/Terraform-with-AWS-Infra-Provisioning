## Summary of the Business Contexts

A startup wants PCI‑DSS certification. The audit found that PCI‑DSS 1.3.1 and 1.3.2 are not implemented correctly.:
PCI‑DSS 1.3.1
##
Inbound traffic to the CDE must be restricted to only necessary IP addresses.
##
PCI‑DSS 1.3.2
##
Outbound traffic must be restricted to only necessary destinations, protocols, & ports.
##
Right now the environment has the following below:

Outbound: ALLOW ALL →  PCI violation
Inbound: HTTP 80 from 0.0.0.0/0 → PCI violation
Uses external repo example.com & service secureweb.com
No automation, everything manual
Audit in 5 days



## Next Step: Solutions / Suggestion

##
## Terraform POC of the entire infrastructure

VPC
Private & public subnets ( 2 Private subnets and 1 public subnet)
EC2 App instance
EC2 MySQL instance
ALB (HTTPS, with ACM cert)
Security Groups
route tables & nat-gateway


## Security controls to satisfy PCI 1.3.1 & 1.3.2
## Inbound Requirements

ALB only accepts HTTPS (port 443)
Only from a finite IP allowlist
App EC2 only accepts from ALB SG
DB EC2 only accepts from App SG
No public IP on EC2s

## Outbound Requirements
App EC2 must access only:
example.com (to install package)
secureweb.com (HTTPS communication)
DB only talks MySQL to APP
Everything else blocked