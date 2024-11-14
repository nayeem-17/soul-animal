title Soul Animal Application Architecture

Client [icon: azure-browser]

GitHub [icon: github] {
    Repository [icon: code] {
        App Code [icon: code]
        IaC [icon: terraform, label: "Terraform Code"]
    }
    Actions [icon: github-actions] {
        Build [icon: box, label: "Build & Test"]
        Push [icon: box, label: "Push to Registry"]
    }
}

Azure Infrastructure [icon: azure] {
    Resource Group [icon: azure-resource-group] {
        ACR [icon: azure-container-registries, label: "Azure Container Registry"] {
            Images [icon: box, label: "Soul Animal Images"]
            Webhooks [icon: box, label: "Deployment Hooks"]
        }
        Virtual Network [icon: azure-virtual-networks] {
            Public Subnet [icon: azure-subnet] {
                VM [icon: azure-vm] {
                    Docker [icon: docker] {
                        Container1 [icon: box, label: "FastAPI App"]
                        Container2 [icon: box, label: "PostgreSQL"]
                    }
                }
                NSG1 [icon: azure-nsg, label: "Public NSG"] {
                    Rule1 [icon: box, label: "Allow 80,443"]
                    Rule2 [icon: box, label: "Allow 22"]
                }
            }
            Private Subnet [icon: azure-subnet] {
                Key Vault [icon: azure-key-vaults]
                NSG2 [icon: azure-nsg, label: "Private NSG"] {
                    Rule1 [icon: box, label: "Allow VM Access"]
                    Rule2 [icon: box, label: "Deny Internet"]
                }
            }
        }
        Public IP [icon: azure-ip, label: "Static IP"]
        Managed Identity [icon: azure-iam-identity]
    }
}

Application [icon: box] {
    FastAPI [icon: box, label: "Soul Animal App\nPort 8000"]
    Database [icon: postgresql, label: "PostgreSQL\nPort 5432"]
}

// Infrastructure Provisioning
IaC --> Azure Infrastructure:Provisions All Resources

// Application Flow
Client --> Public IP:HTTP Port 80
Public IP --> VM:Forward Traffic
App Code --> Actions:Trigger on Push or PR
Build --> Push:On Success
Push --> ACR:Push Images
ACR --> VM:Pull Images via Private Link
VM --> FastAPI:Deploy
VM --> Database:Deploy
FastAPI --> Database:Connects
VM --> Private Subnet:Access via Service Endpoint
VM --> Managed Identity:Uses
Managed Identity --> Key Vault:Access Secrets via Private Endpoint
Managed Identity --> ACR:Authenticate for Image Pull
FastAPI --> Key Vault:Fetch DB Credentials via Private Endpoint