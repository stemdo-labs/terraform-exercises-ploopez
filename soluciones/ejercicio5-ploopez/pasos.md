PS C:\Users\plopez\Documents\Github\terraform-exercises-ploopez\soluciones\ejercicio5-ploopez> terraform init   

Initializing the backend...
Initializing modules...

Initializing provider plugins...
- Reusing previous version of hashicorp/azurerm from the dependency lock file
- Using previously-installed hashicorp/azurerm v3.102.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.


PS C:\Users\plopez\Documents\Github\terraform-exercises-ploopez\soluciones\ejercicio5-ploopez> terraform plan   

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.ejercicio5.azurerm_virtual_network.vnet will be created
  + resource "azurerm_virtual_network" "vnet" {
      + address_space       = [
          + "10.0.0.0/16",
        ]
      + dns_servers         = (known after apply)
      + guid                = (known after apply)
      + id                  = (known after apply)
      + location            = "westeurope"
      + name                = "vnetplopeztfexercise01"
      + resource_group_name = "rg1plopez-lab01"
      + subnet              = (known after apply)
      + tags                = {
          + "Department"      = "IT"
          + "environment_tag" = "pRE"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.


PS C:\Users\plopez\Documents\Github\terraform-exercises-ploopez\soluciones\ejercicio5-ploopez> terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.ejercicio5.azurerm_virtual_network.vnet will be created
  + resource "azurerm_virtual_network" "vnet" {
      + address_space       = [
          + "10.0.0.0/16",
        ]
      + dns_servers         = (known after apply)
      + guid                = (known after apply)
      + id                  = (known after apply)
      + location            = "westeurope"
      + name                = "vnetplopeztfexercise01"
      + resource_group_name = "rg1plopez-lab01"
      + subnet              = (known after apply)
      + tags                = {
          + "Department"      = "IT"
          + "environment_tag" = "pRE"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.ejercicio5.azurerm_virtual_network.vnet: Creating...
module.ejercicio5.azurerm_virtual_network.vnet: Creation complete after 5s 
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

PS C:\Users\plopez\Documents\Github\terraform-exercises-ploopez\soluciones\ejercicio5-ploopez> terraform destroy
module.ejercicio5.azurerm_virtual_network.vnet: Refreshing state...
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # module.ejercicio5.azurerm_virtual_network.vnet will be destroyed
  - resource "azurerm_virtual_network" "vnet" {
      - address_space           = [
          - "10.0.0.0/16",
        ] -> null
      - dns_servers             = [] -> null
      - flow_timeout_in_minutes = 0 -> null
      - guid                    = x -> null
      - id                      = x -> null
      - location                = "westeurope" -> null
      - name                    = "vnetplopeztfexercise01" -> null
      - resource_group_name     = "rg1plopez-lab01" -> null
      - subnet                  = [] -> null
      - tags                    = {
          - "Department"      = "IT"
          - "environment_tag" = "pRE"
        } -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

module.ejercicio5.azurerm_virtual_network.vnet: Destroying... 
module.ejercicio5.azurerm_virtual_network.vnet: Still destroying... 
module.ejercicio5.azurerm_virtual_network.vnet: Destruction complete after 10s

Destroy complete! Resources: 1 destroyed.


Siendo las x contenido sensible