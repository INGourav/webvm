resource "azurerm_virtual_machine" "vm" {
  name                  = "AzureTestWeb1"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_D8s_v3"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

    storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "AzureTestVM1-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = "128"
  }

  storage_data_disk {
      name                      = "AzureTestVM1-disk1"
      caching                   = "None"
      create_option             = "Empty"
      disk_size_gb              = 512
      lun                       = 0
      managed_disk_type         = "Premium_LRS"
  }

  os_profile {
    computer_name  = "AzureTestVM1"
    admin_username = "AzureTestVM1-adm"
    admin_password = random_string.password_vm.result
  }

  os_profile_windows_config {
      provision_vm_agent = true
      timezone           = "UTC"
    }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = azurerm_storage_account.storage.primary_blob_endpoint
  }
  
  tags = {
    environment = "Production"
  }
}
