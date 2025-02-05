module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version        = "~> 20.31"
  cluster_name    = "test-cluster"
  cluster_version = "1.31"
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.public_subnets

  cluster_addons = {
    coredns                   = {}
    eks-pod-identity-agent    = {}
    kube-proxy                = {}
    vpc-cni                   = {}
  }

  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  cluster_endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

