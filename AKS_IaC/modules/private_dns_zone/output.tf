output "priv_dns_zone_name" {
    value = azurerm_private_dns_zone.private-dns01.name
}

output "priv_dns_zone_id" {
    value = azurerm_private_dns_zone.private-dns01.id
}

#output "priv_dns_zone_fqdn" {
#    value = azurerm_private_dns_zone.private-dns01.fqdn
#}