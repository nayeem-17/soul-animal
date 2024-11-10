#!/bin/bash

# Set strict error handling
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging function
log() {
    local level=$1
    shift
    local message=$*
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    case "$level" in
        "INFO")  echo -e "${GREEN}[INFO]${NC} ${timestamp} - $message" ;;
        "WARN")  echo -e "${YELLOW}[WARN]${NC} ${timestamp} - $message" ;;
        "ERROR") echo -e "${RED}[ERROR]${NC} ${timestamp} - $message" ;;
    esac
}

# Function to check if terraform is installed
check_terraform() {
    if ! command -v terraform &> /dev/null; then
        log "ERROR" "Terraform is not installed. Please install Terraform first."
        exit 1
    fi
}

# Define a function that takes the base directory as an input parameter
tf_destroy() {
    local base_directory="$1"
    log "INFO" "Destroying infrastructure in: $base_directory"
    
    # Check if .terraform directory exists
    if [ ! -d "$base_directory/.terraform" ]; then
        log "WARN" "No .terraform directory found in $base_directory. Running terraform init..."
        (cd "$base_directory" && terraform init) || {
            log "ERROR" "Terraform init failed in $base_directory"
            return 1
        }
    fi
    
    # Attempt to destroy
    (cd "$base_directory" && terraform destroy --auto-approve) || {
        log "ERROR" "Terraform destroy failed in $base_directory"
        return 1
    }
    
    log "INFO" "Successfully destroyed infrastructure in: $base_directory"
}

iterate_to_destroy() {
    local base_directory="$1"
    
    # Check if directory exists and is readable
    if [ ! -d "$base_directory" ] || [ ! -r "$base_directory" ]; then
        log "ERROR" "Directory $base_directory does not exist or is not readable"
        return 1
    fi
    
    # Use a for loop to iterate through subdirectories
    for dir in "$base_directory"/*; do
        if [ -d "$dir" ]; then
            full_path=$(readlink -f "$dir")
            dir_name=$(basename "$dir")
            
            # Skip special directories
            if [[ "$dir_name" =~ ^(\.terraform|env|backend)$ ]]; then
                continue
            fi
            
            # Count .tf files
            count=$(find "$dir" -maxdepth 1 -name "*.tf" | wc -l)
            
            if [ $count -ne 0 ]; then
                tf_destroy "$full_path" || {
                    log "ERROR" "Failed to destroy $full_path"
                    continue
                }
            fi
            
            # Recursively process subdirectories
            iterate_to_destroy "$full_path"
        fi
    done
}

main() {
    # Check for terraform installation
    check_terraform
    
    # Get base directory from argument or use current directory
    local base_dir="${1:-.}"
    
    log "INFO" "Starting terraform destroy process from directory: $base_dir"
    
    # Verify base directory exists
    if [ ! -d "$base_dir" ]; then
        log "ERROR" "Base directory $base_dir does not exist"
        exit 1
    fi
    
    # Execute the main function
    iterate_to_destroy "$base_dir"
    
    log "INFO" "Terraform destroy process completed"
}

# Execute main function with proper error handling
main "$@" || {
    log "ERROR" "Script execution failed"
    exit 1
}

