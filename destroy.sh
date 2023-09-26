#!/bin/bash

# Define a function that takes the base directory as an input parameter
tf_destroy() {
  local base_directory="$1"
  echo "destroying $base_directory"
  cd "$base_directory" 
  terraform destroy --auto-approve
  cd -
}

iterate_to_destroy(){
  local base_directory="$1"
  # Use a for loop to iterate through subdirectories
  for dir in "$base_directory"/*; do
      if [ -d "$dir" ] ; then  # Check if it's a directory
          # echo "$dir"
          count=$(ls -1 "$dir"| grep -E '\.tf$' | wc -l)
          # echo $count
          full_path=$(readlink -f "$dir")
          dir_name=$(basename "$dir")
          # echo $dir_name
          if [[ "$dir_name" == ".terraform" ]] || [[ "$dir_name" == "env" ]] || [[ "$dir_name" == "backend" ]]; then
              continue
          fi
          if [ $count -ne 0 ]; then
            tf_destroy "$full_path"
          fi
          iterate_to_destroy "$full_path"
      fi
  done
}

# Call the function with the base directory as an argument
base_dir="."
iterate_to_destroy "$base_dir"

