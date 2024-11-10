# This is a simple application written in FastApi which will tell you your soul animal
I want to deploy the application so a lot of people can see their soul animals. I will deploy this to aws but I do not want to log in into aws console again and again.
## Tech Stack
- FastApi as backend 
- Postgres as database
- Terraform for infrastructure provisioning and management

## 1. Initial Setup
- [ ] Create backend storage account for state
  - Create resource group for state storage
  - Create storage account
  - Create container
- [ ] Set up provider configurations
  - Azure provider settings
  - Version constraints
  - Feature flags
- [ ] Define base variables
  - Environment variables
  - Common tags

## 2. Module Development

### 2.1 Network Module
- [ ] Virtual Network
- [ ] Subnets
  - Subnet delegations
  - Service endpoints
  - Network security groups association
- [ ] Application Gateway
  - Routing rules
  - Health probes
- [ ] Network Security Groups
  - Inbound security rules
  - Outbound security rules
  - Application security groups

### 2.2 Security Module
- [ ] Managed Identity
  - User-assigned identity creation
  - Role assignments
- [ ] Key Vault
  - Access policies
  - Network access rules
  - Secret management

### 2.3 Compute Module

- [ ] Web App
  - Runtime stack
  - Deployment configurations
- [ ] App Settings
  - Environment variables
  - Connection strings
<!-- 

### 2.4 Database Module
- [ ] SQL Server
  - Authentication settings
  - Firewall rules
  - Auditing configuration
- [ ] SQL Database
  - Performance settings
  - Backup configuration
  - Geo-replication
- [ ] Network Rules
  - VNET integration
  - Private endpoints
  - Service endpoints -->

## 3. Environment Configuration

### 3.1 Dev Environment
- [ ] Variables
  - Development-specific values
  - Reduced SKUs
  - Debug settings
- [ ] Network configs
  - Development CIDR ranges
  - Simplified routing
  - Test certificates
- [ ] Security settings
  - Relaxed policies for testing
  - Developer access
  - Monitoring settings
