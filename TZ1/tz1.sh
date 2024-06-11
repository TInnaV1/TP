#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_dir> <output_dir>"
    exit 1
fi

input_dir="$1"
output_dir="$2"

chmod -R +xr "$input_dir"

shopt -s dotglob

find "$input_dir" -type f | while read file; do
    file_name=$(basename -- "$file")
    end_file_path="$output_dir/$file_name"
    counter=1

    while [ -e "$end_file_path" ]; do
        name="${file_name%.*}"
        extension="${file_name##*.}"
        if [[ "$file_name" == *.* ]]; then
            end_file_path="$output_dir/${name}_$counter.$extension"
        else
            end_file_path="$output_dir/${name}_$counter"
        fi
        ((counter++))
    done

    cp "$file" "$end_file_path"

done



