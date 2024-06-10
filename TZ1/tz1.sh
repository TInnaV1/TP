#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_dir> <output_dir>"
    exit 1
fi

input_dir="$1"
output_dir="$2"

find "$input_dir" -type f -print0 | while IFS= read -r -d '' file; do
    name=$(basename "$file")
    new_name="$name"
    counter=1
    while [ -e "$output_dir/$new_name" ]; do
        base="${name%.*}"
        ext="${name##*.}"
        new_name="${base}_${counter}.${ext}"
        ((counter++))
    done
    cp -p "$file" "$output_dir/$new_name"
done


