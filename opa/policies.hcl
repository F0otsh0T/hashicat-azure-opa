/* policy "friday_deploys" {
  query = "data.terraform.policies.friday_deploys.deny"
  enforcement_level = "mandatory"
} */

/* policy "instance_types" {
  query             = "data.terraform.policies.instance_types.deny"
  enabled           = true
  enforcement_level = "advisory"
} */

/* policy "instance_types" {
  query             = "data.terraform.policies.instance_types.deny"
  enforcement_level = "advisory"
} */

policy "instance_types" {
  query             = "data.terraform"
  enforcement_level = "mandatory"
}
