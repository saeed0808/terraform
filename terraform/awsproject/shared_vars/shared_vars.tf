output "vpcid" {
  value = "${local.vpcid}"
}

output "publicsubnetid1" {
  value = "${local.publicsubnetid1}"
}

output "publicsubnetid2" {
  value = "${local.publicsubnetid2}"
}

output "privatesubnetid" {
  value = "${local.privatesubnetid}"
}

output "env_suffix" {
   value = "${local.env}"
}

output "amiid" {
   value = "${local.amiid}"
}

output "instancetype" {
   value = "${local.instancetype}"
}

locals {
   env = "${terraform.workspace}"

   vpcid_env = {
      default = "vpc-018fd4cce79408a58"
      staging   = "vpc-018fd4cce79408a58"
      producation = "vpc-018fd4cce79408a58"
   }  
   vpcid = "${lookup(local.vpcid_env, local.env)}"
 

   publicsubnetid1_env = {
      default = "subnet-09692835e49a0f78b"
      staging   = "subnet-09692835e49a0f78b"
      producation = "subnet-09692835e49a0f78b"
   }  
   publicsubnetid1 = "${lookup(local.publicsubnetid1_env, local.env)}"

   publicsubnetid2_env = {
      default = "subnet-0958daceafe1a422e"
      staging   = "subnet-0958daceafe1a422e"
      producation = "subnet-0958daceafe1a422e"
   }  
   publicsubnetid2 = "${lookup(local.publicsubnetid2_env, local.env)}"   


   privatesubnetid_env = {
      default = "subnet-00919b881822dc687"
      staging   = "subnet-00919b881822dc687"
      producation = "subnet-00919b881822dc687"
   }  
   privatesubnetid = "${lookup(local.privatesubnetid_env, local.env)}"  

   amiid_env = {
      default = "ami-0c02fb55956c7d316"
      staging   = "ami-0c02fb55956c7d316"
      producation = "ami-0c02fb55956c7d316"
   }  
   amiid = "${lookup(local.amiid_env, local.env)}" 

   instancetype_env = {
      default = "t2.micro"
      staging   = "t2.micro"
      producation = "t2.medium"
   }  
   instancetype = "${lookup(local.instancetype_env, local.env)}" 
}