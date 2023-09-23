#!/bin/bash

# Define a function that takes the base directory as an input parameter
tf_destroy() {
  local base_directory="$1"
  echo "destroying $base_directory"
  cd "$base_directory" 
  terraform destroy --auto-approve
cd -

  # Use a for loop to iterate through subdirectories
  for dir in "$base_directory"/*; do
      if [ -d "$dir" ] ; then  # Check if it's a directory
          echo "$dir"
          full_path=$(readlink -f "$dir")
          dir_name=$(basename "$dir")
          echo $dir_name
    if [[ "$dir_name" == ".terraform" ]] || [[ "$dir_name" == "env" ]] || [[ "$dir_name" == "backend" ]]; then
  continue
fi
          tf_destroy "$full_path"
      fi
  done
}

# Call the function with the base directory as an argument
base_dir="."
tf_destroy "$base_dir"

