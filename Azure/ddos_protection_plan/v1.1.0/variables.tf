#DDOS protection plan variable
variable "ddos_protection_plan_variables" {
  type = map(object({
    name                      = string
    resource_group_name       = string
    location                  = string
    ddos_protection_plan_tags = map(string)
  }))
}