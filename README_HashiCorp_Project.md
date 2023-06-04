# HashiCorp Sentinel Policy as Code Project

HashiCorp is a software company that provides modular DevOps infrastructure management for all types of cloud environments- public, private, and multicloud.  This project explores one of HashiCorp's hallmark offerings: Terraform and its embeddable policy as code framework, HashiCorp Sentinel.

These offerings enables orginizations to introduce infrastructure automation and security automation into a cloud environment. They are detailed below:


1. Terraform enables users to leverage Infrastructure as Code (IaC) to automate infrastructure management in the cloud- this enables DevOps teams to introduce standardization and consistency within infrastructure while also reducing the potential for misconfigurations and resource sprawl. IaC also enables increased speed of deployment to cloud environments.
	
2. HashiCorp Sentinel enables the codification of security policies at the object- level which allows DevSecOps teams to meet security and compliance requirements by enforcing rules, regulations, and best practices for infrastructure deployments across a cloud environment. Policy-as-Code (PaC) can also automate security testing by arresting infrastructure created insecurely before it goes to production- thereby verifying the cloud environment remains secure and greatly reduces the possibility that recource configurations will introcude vulnerabilities.


*This project explores the security automation (#2) capabilities of HashiCorp Sentinel, however, supporting infrastructure automation scripts are also detailed.*

	
## About the policies

The following custom policies were developed using the CIS Benchmarks for the Google Cloud Platform. CIS (Center for Internet Security) has created public, open- source documentation detailing best practices and important security considerations when designing infrastructure on Google Cloud Platform. The latest update is dated March 2022 (this is a living document that continues to be updated). I used the best practices found in this CIS Benchmarks document to develop custom policies.

The custom policies in this repository are numbered and correspond to the policy documentation in the CIS benchmarks for Google Cloud.

## How to Test HashiCorp Sentinel Policies using open- source, community tools

The functionality of these policies are tested against the Sentinel CLI (Command Line Interface).
The download is found here: https://docs.hashicorp.com/sentinel/downloads 

Each custom policy outcome is based on an infrastructure configuration (Terraform IaC). Before the Infrastructure in created, Terraform creates a speculative plan (mock file) to show what Infrastructure would be implemented in production. The policy scripts check to ensure the mock file is in compliance with all policies and rules, if it is, the policy is passed and the infrastructure is deployed. 

I have developed 2 scenarios for each policy: a pass scenario (in which the infrastructure is compliant) and a fail scenario (in which the infrastructure is not compliant).

## HashiCorp's proprietary language

I used HashiCorp Configuration Language (HCL) to develop the IaC and PaC scripts. HCL is a language developed by HashiCorp to support programmatic use with its cloud infrastructure automation tools, such as Terraform.


## Development of Policy as Code and Workflow

Regardless of the type of policy, there is a common workflow that is followed for the development of each policy.

1. A 'main.tf' file containing the IaC script is created, this represents the infrastructure configuration to be deployed onto the cloud platform.
2. Using this script, we run a speculative plan using the 'terraform plan' command to review the potential changes and additions to our cloud infrastructure. The outcome is a 'mock' file describing all of the resources and configuration changes if the infrastructure automation script is deployed to the cloud environment.
3. Using this speculative plan, we identify and configure policies and rules to ensure our resources and cloud environment is following security best practices. The outcome is a Policy as Code script that continuously monitors infrastructure changes for potential misconfigurations and insecure deployments.
4. In order to ensure our Policy as Code script is effective in arresting/ blocking the creation of resources that do not follow security best practices, we create pass and fail scenarios to thoroughly test the policy.
5. Once we test the infrastructure as Code script and it passes all policies and rules, we can be confident that the infrastructure follows best practices per CIS (Center for Internet Security). Deployment via the 'terraform apply' command is the final step. 


