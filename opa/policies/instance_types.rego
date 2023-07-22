# Multi proivder rule to enforce instnace type/size
# Source: https://github.com/Scalr/sample-tf-opa-policies/blob/master/management/instance_types.rego

package terraform
#package terraform.policies.instance_type

#import input.tfplan as tfplan
import input.plan as tfplan
#import input.plan as plan

# Allowed sizes by provider
allowed_types = {
    "aws": ["t2.nano", "t2.micro"],
    "azurerm": [ "Standard_A0", "Standard_A1"],
    "google": ["n1-standard-1", "n1-standard-2"]
}

# Attribute name for instance type/size by provider
# instance_type_key = {
#     "aws": "instance_type",
#     "azurerm": "vm_size",
#     "google": "machine_type"
# }
instance_type_key = {
    "aws": "instance_type",
    "azurerm": "size",
    "google": "machine_type"
}

array_contains(arr, elem) {
  arr[_] = elem
}

get_basename(path) = basename{
    arr := split(path, "/")
    basename:= arr[count(arr)-1]
}

# Extracts the instance type/size
get_instance_type(resource) = instance_type {
    # registry.terraform.io/hashicorp/aws -> aws
    provider_name := get_basename(resource.provider_name)
    instance_type := resource.change.after[instance_type_key[provider_name]]
}

deny[reason] {
    resource := tfplan.resource_changes[_]
    instance_type := get_instance_type(resource)
    # registry.terraform.io/hashicorp/aws -> aws
    provider_name := get_basename(resource.provider_name)
    not array_contains(allowed_types[provider_name], instance_type)

    reason := sprintf(
        "%s: instance type %q is not allowed",
        [resource.address, instance_type]
    )
}