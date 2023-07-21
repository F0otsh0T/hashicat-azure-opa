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
  query             = "data.terraform.policies.instance_types.deny"
  enforcement_level = "mandatory"
}
