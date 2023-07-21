package azure.vm_restrictions

import input.plan as tfplan

# Define the allowed virtual machine sizes
allowedVMTypes = {
    "Standard_B2s",
    "Standard_B4ms",
    "Standard_DS1_v2",
    "Standard_DS2_v2",
    "Standard_DS3_v2",
    "Standard_DS4_v2",
}

# Policy to enforce allowed virtual machine types in Microsoft Azure
default allow = false

allow {
    input.virtualMachine["azure:vm:size"] == vmType
    vmType == allowedVMTypes[_]
}
