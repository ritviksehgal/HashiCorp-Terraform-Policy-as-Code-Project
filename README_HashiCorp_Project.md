# HashiCorp-Sentinel-Policy-as-Code-Project

HashiCorp is a software company that provides modular DevOps infrastructure management for all types of cloud environment- public, private, and multi- cloud.  This project explores one of HashiCorp's hallmark products: Terraform

Terraform is a cloud- agnostic SaaS (Software as a Service) application that is used by DevOps engineers for purposes of Infrastructure management and codification of security policies in a cloud environment. In essence, Terraform is an Infrastructure as Code (IaC) tool that automates infrastructure provisioning on cloud platforms including AWS (Amazon Web Services), Google Cloud Platform (GCP), and Azure (Microsoft).

This project explores two key capabilities of Terraform: Infrastructure automation and security automation

1. Terraform allows users to leverage Infrastructure as Code (IaC) to automate infrastructure management- this enables DevOps teams to introduce
standardization and consistency within infrastructure while also reducing the potential for misconfigurations and resource sprawl.
IaC also enables increased speed of deployment to cloud enviorements.
	
2. The codification of security policies enables DevOps teams to meet security and compliance requirements by enforcing rules, regulations, and best practices for infrastructure deployments across the cloud enviorement.
PaC can also automate security testing by catching infrastructure created insecurely 
before it goes to production- thereby verifying the cloud enviorement remains secure and the threat landscape
is reduced to the extent possible. HashiCorp Sentinel is a Policy-as-Code (PaC) framework that enables this.
	
# About the policies

The following custom policies were developed using the CIS Benchmarks for the Google Cloud Platform. CIS (Center for Internet Security) has created public, open- source documentation detailing best practices and important security considerations when designing an infrastructure on Google Cloud Platform. The latest version was updated March 2022. I used the best practices found in this CIS Benchmarks document to develop custom policies.

The custom policies in this repository are numbered and correspond to the policy documentation in the CIS benchmarks for Google Cloud.

For each policy, I have written documentation describing what the script does, pass/fail cases, and a summary of the best practice.

# How to Test HashiCorp Sentinel Policies using open- source, community tools

The functionality of these policies are tested against the Sentinel CLI (Command Line Interface).
The download is found here: https://docs.hashicorp.com/sentinel/downloads 

Each custom policy outcome is based on the infrastruction configuration (Terraform IaC). Before the Infrastructure in created, Terraform creates a speculative plan (mock file) to show what the Infrastructure would be implemented in production. The policy checks to ensure the mock file is in compliance, if it is, the policy is passed and the infrastructure is created. 

I have developed 2 scenarios for each policy: a pass scenario (in which the infrastructure is compliant) and a fail scenario (in which the infrastructure is not compliant).

# HashiCorp's proprietary language

I used Hashicorp Configuration Language (HCL) to develop the IaC and PaC scripts. HCL is used with HashiCorp's cloud infrastructure automation tools, such as Terraform.


# Developement of Policy as Code and Workflow

Regardless of the type of policy, there is a common workflow that is followed for the developement of each policy.

1. A 'main.tf' file containing the IaC script is created, this represents the infrastructure configuration to be deployed onto the cloud platform.
2. Using this script, we run a sepeclative plan using the 'terraform plan' command to review the potentioal changes and additions to our cloud infrastructure. The outcome is a 'mock' file describing all of the resources and configuration changes if the infrastrucute automation script is deployed.
3. Using this speculative plan, we determine how best to apply best practices onto a specific cloud resource/ service. The outcome is a Policy as Code script that continuously monitors infrastructure chanages for potential misconfigurations and insecure deployements.
4. Next, we create pass and fail senarios to thoroughly test the Policy. Note: for every policy there is only 1 pass senarios (the one that follows best practices). However, each policy can have multiple fail senarios. For purposes of this project, only 1 fail senario is created.
5. Once we test the Infrasturcture as Code script and it passes all policies, we can be confident that the infrastucure follows best practices per CIS (Center for Internet Security). Deployement via the 'terraform apply' command is the final step. 


