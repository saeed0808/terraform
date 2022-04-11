module "shared_vars" {
  source = "../shared_vars"
}

variable "privatesg_id" {}
variable "tg_arn" {}

locals {
  env = "${terraform.workspace}"

  amiid_env = {
      default = "ami-04505e74c0741db8d"
      staging   = "ami-04505e74c0741db8d"
      producation = "ami-04505e74c0741db8d"
   }  
   amiid = "${lookup(local.amiid_env, local.env)}" 

   instancetype_env = {
      default = "t2.micro"
      staging   = "t2.micro"
      producation = "t2.medium"
   }  
   instancetype = "${lookup(local.instancetype_env, local.env)}" 

   keypairname_env = {
      default = "staging"
      staging   = "staging"
      producation = "myKey_mannual"
   }  
   keypairname = "${lookup(local.keypairname_env, local.env)}" 

   asgdesired_env = {
      default = "1"
      staging   = "0"
      producation = "2"
   }  
   asgdesired = "${lookup(local.asgdesired_env, local.env)}" 

   asgmin_env = {
      default = "1"
      staging   = "0"
      producation = "2"
   }  
   asgmin= "${lookup(local.asgmin_env, local.env)}" 

   asgmax_env = {
      default = "1"
      staging   = "0"
      producation = "2"
   }  
   asgmax = "${lookup(local.asgmax_env, local.env)}"       
}

resource "aws_launch_configuration" "reportica_lc" {
  name          = "reportica_lc_${local.env}"
  image_id      = "${local.amiid}"
  instance_type = "${local.instancetype}"
  key_name      = "${local.keypairname}"
  user_data     = "${file ("assets/userdata.txt")}"
  security_groups = ["${var.privatesg_id}"]
}

#######################################################################
resource "aws_autoscaling_group" "reportica_asg" {
  name                      = "reportica_asg_${module.shared_vars.env_suffix}"
  max_size                  = "${local.asgmax}"
  min_size                  = "${local.asgmin}"
  desired_capacity          = "${local.asgdesired}"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.reportica_lc.name}"
  vpc_zone_identifier       = ["${module.shared_vars.publicsubnetid1}"]
  target_group_arns         = "${var.tg_arn}"

  tags = [ {
    "key"                   = "Name"
    "value"                 = "reportica_${module.shared_vars.env_suffix}"
    "propagate_at_launch"   = true
    },
    {
      key                   = "Environment"
      value                 = "${module.shared_vars.env_suffix}"
      propagate_at_launch   = true
    } 
  ]
}