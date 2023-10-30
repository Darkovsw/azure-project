# Basic Variables
variable "location" {
    description = "This variable is responsible for Azure region"
    default = "West Europe"
}

variable "linvmnumber" {
    description = "This variable is responsible for number of linux VMs that will be created"
    default = "1"
}

variable "winvmnumber" {
    description = "This variable is responsible for number of windows VMs that will be created"
    default = "1"
}

variable "size" {
    description = "This variable is responsible for parameters of specific VM such as RAM, proc etc."
    default = "Standard_F2"
}

variable "filesharesize" {
    description = "This variable is responsible for the capacity of file share in GB"
    default = "5"
}

variable "rg_name" {
    description = "Resource group name."
    default = "Environment-RG"
}

variable "vn_name" {
    description = "Virtual network name/"
    default = "environment_net"
}

variable "vn_addrspace" {
    description = "Virtual network address space."
    default = ["10.0.0.0/16"]
}

variable "sn_name" {
    description = "Subnet name."
    default = "internal"
}

variable "sn_addrprfx" {
    description = "Subnet address prefixes."
    default = ["10.0.2.0/24"]
}

variable "nsg_name" {
    description = "Network security group name for windows machines."
    default = "env-nsg1"
}

variable "nsg_name1" {
    description = "Network security group name for linux machines."
    default = "env-nsg2"
}

# Windows VMS
variable "win_publisher" {
    description = "Publisher value"
    default = "MicrosoftWindowsDesktop"
}

variable "win_offer" {
    description = "Offer value"
    default = "Windows-10"
}

variable "win_sku" {
    description = "Sku value"
    default = "20h2-evd"
}

variable "win_version" {
    description = "Version value"
    default = "latest"
}

variable "user_name" {
    description = "Windows vm user name."
    default = "contosoadmusr"
}

variable "win_compname" {
    description = "Windows vm name."
    default = "winvm"
}

# Linux VMS
variable "lin_publisher" {
    description = "Publisher value"
    default = "Canonical"
}

variable "lin_offer" {
    description = "Offer value"
    default = "0001-com-ubuntu-server-jammy"
}

variable "lin_sku" {
    description = "Sku value"
    default = "22_04-lts"
}

variable "lin_version" {
    description = "Version value"
    default = "latest"
}

variable "lin_usrname" {
    description = "Linux vm user name."
    default = "contosolinusradm"
}

variable "computer_name" {
    description = "Linux vm computer name."
    default = "linvm"
}

# Storage Account
variable "storageacc_name" {
    description = "Storage account name."
    default = "storaccmain"
}

variable "storageacc_tier" {
    description = "Storage account - account tier."
    default = "Standard"
}

variable "storageacc_replication" {
    description = "Storage account - account replication type."
    default = "LRS"
}

variable "storageshare_name" {
    description = "Storage account - file share name."
    default = "fs01"
}

variable "storageshare_quota" {
    description = "The maximum size of the share."
    default = 5
}

# Tags Informations
variable "environment" {
    description = "Use it in tags to describe type of environment, for example production, testing, development etc."
    default = "development"
}

variable "author" {
    description = "Use it in tags for the name of the creator of the deployment."
    default = "example_user"
}
