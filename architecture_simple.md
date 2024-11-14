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

Docker Hub [icon: azure-container-registries]

Azure Infrastructure [icon: azure] {
    Resource Group [icon: azure-resource-group] {
        Virtual Network [icon: azure-virtual-networks] {
            Public Subnet [icon: azure-subnet] {
                VM [icon: azure-vm] {
                    Docker [icon: docker] {
                        Container1 [icon: box, label: "FastAPI App"]
                        Container2 [icon: box, label: "PostgreSQL"]
                    }
                }
                NSG [icon: azure-nsg, label: "Network Security Group"] {
                    Rule1 [icon: box, label: "Allow 80,443"]
                    Rule2 [icon: box, label: "Allow 22"]
                }
            }
        }
        Public IP [icon: azure-ip, label: "Static IP"]
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
Push --> Docker Hub:Push Images
Docker Hub --> VM:Pull Latest Image
VM --> FastAPI:Deploy
VM --> Database:Deploy
FastAPI --> Database:Connects 