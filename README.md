# VPC

Terraform module for **Virtual Private Cloud with configurable subnets, NAT gateways, and route tables**.

See `variables.tf` for available configuration options and `outputs.tf` for module outputs.

## Requirements

- Terraform >= 1.5.7
- AWS provider >= 6.28

## Usage

```hcl
module "vpc" {
  source = "git::https://github.com/dcli-com/aws-iac.git//vpc?ref=main"

  # Required variables
  project     = "core"
  environment = "prod"
  region      = "us-east-2"
  
  # Module-specific configuration
  # See variables.tf for full list

  tags = {
    Team = "Platform"
  }
}
```

## Inputs

See `variables.tf` for all available variables.

## Outputs

See `outputs.tf` for available outputs.

## References

- [AWS Vpc Documentation](https://docs.aws.amazon.com)

## Related Modules

See `CLAUDE.md` in the repository root for the full module dependency graph.
