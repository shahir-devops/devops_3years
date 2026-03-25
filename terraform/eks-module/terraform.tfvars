ami_type       = "AL2023_x86_64_STANDARD"
cidr          = "10.0.0.0/16"
instance_type = "t3.micro"

vpcname         = "zalando"
private_subnets = [
    "10.0.0.0/18",
    "10.0.64.0/18"
]
public_subnets  = [
    "10.0.128.0/18",
    "10.0.192.0/18"
]

region       = "ap-south-1"
cred_profile = "terraformprofile"

min_size     = 2
max_size     = 5
desired_size = 3
