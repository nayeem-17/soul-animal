#!/bin/bash

# Get the private key and save it
terraform output -raw tls_private_key > vm_private_key.pem

# Set correct permissions for the private key
chmod 600 vm_private_key.pem

# Get the VM's public IP
VM_IP=$(terraform output -raw vm_public_ip)

# Remove old host key if it exists
ssh-keygen -f "/home/synesis/.ssh/known_hosts" -R "$VM_IP"

# Print connection instructions
echo "Connecting to VM at $VM_IP..."
echo "Using username: azureuser"

# Connect to the VM with StrictHostKeyChecking=no for first connection
ssh -o StrictHostKeyChecking=accept-new -i vm_private_key.pem azureuser@$VM_IP
