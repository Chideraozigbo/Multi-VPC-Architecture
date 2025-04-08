# AWS VPC Architecture Documentation

## Background Story

As a data engineer, I've often found myself jumping between tools, environments, and use cases from analytics pipelines to ML model deployments. But as our workloads began to scale, so did our need for a secure, highly available, and automatable infrastructure setup.

That's when I decided to bring structure to the picture. I designed a VPC-based architecture on AWS that not only supports a hybrid workload with public and private subnets but also enables cross VPC communication via VPC peering. Of course, as a fan of Infrastructure as Code (IaC), I went with Terraform to automate and version control the entire setup.

## Medium Article

For a comprehensive walkthrough of this architecture, check out my Medium article:
[Link to Medium article](https://medium.com/@chideraozigbo/how-i-automated-a-secure-multi-vpc-architecture-on-aws-using-terraform-1effe3e80ea4)

## Architecture Overview

![Architecture Diagram](/architecture.gif)

The infrastructure consists of two VPCs in the Stockholm (eu-north-1) region:

1. **Ingestion VPC** - For data collection and initial processing
2. **Analytics VPC** - For data analysis and visualization

Both VPCs are connected via VPC Peering to enable secure communication between the environments without traversing the public internet.

### Network Details

#### Region: Stockholm (eu-north-1)

#### Ingestion VPC
- **CIDR Block**: 10.10.0.0/16
- **Availability Zone**: eu-north-1a
- **Components**:
  - Public subnet (10.10.0.0/28) - For internet-facing resources
  - Private subnet (10.10.0.16/28) - For protected resources
  - Internet Gateway - Enables communication with the internet
  - Security Groups - Controlling inbound/outbound traffic

#### Analytics VPC
- **CIDR Block**: 10.100.0.0/16
- **Availability Zone**: eu-north-1b
- **Components**:
  - Private subnet (10.100.0.0/28) - For secure analytics processing
  - Security Groups - Controlling inbound/outbound traffic

### Communication Flow

1. Users connect to resources in the public subnet of the Ingestion VPC via the Internet Gateway
2. Resources in the public subnet can communicate with resources in the private subnet of the Ingestion VPC
3. Through VPC Peering, resources in the private subnet of the Ingestion VPC can communicate with resources in the private subnet of the Analytics VPC
4. This multi-layered approach ensures proper isolation while allowing necessary communication paths

### Security Considerations

- Public resources are minimized and restricted to the Ingestion VPC
- Private subnets have no direct internet access
- Security groups are configured to allow only necessary traffic
- VPC Peering provides a secure channel for cross-VPC communication

## Infrastructure as Code

The entire architecture is defined using Terraform, ensuring:

- Version-controlled infrastructure
- Repeatable deployments
- Easy modifications and extensions
- Documentation through code

### Key Terraform Resources

- `aws_vpc` - Defines the VPCs
- `aws_subnet` - Defines the subnets
- `aws_internet_gateway` - Provides internet access
- `aws_vpc_peering_connection` - Establishes the VPC peering
- `aws_security_group` - Defines security rules
- `aws_route_table` - Controls routing between subnets and the internet

## Future Enhancements

- Add NAT Gateways to allow private subnet resources to access the internet
- Implement Transit Gateway for more complex networking scenarios
- Set up VPN connections for secure access from on-premises systems
- Add auto-scaling groups for dynamic resource management

## Getting Started

To deploy this architecture:

1. Install Terraform
2. Clone the repository
3. Configure AWS credentials
4. Initialize Terraform: `terraform init`
5. Plan the deployment: `terraform plan`
6. Apply the changes: `terraform apply`

## Maintenance and Best Practices

- Regularly update security groups to reflect changing requirements
- Monitor VPC flow logs for unexpected traffic
- Use AWS Config and AWS Security Hub for compliance and security monitoring
- Implement tagging strategy for resource management and cost allocation