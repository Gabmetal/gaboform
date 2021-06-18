output "priv_endpoint_id" {
    value = azurerm_private_endpoint.endpointtomysql.id
}

output "priv_endp_ip" {
    value = azurerm_private_endpoint.endpointtomysql
}
