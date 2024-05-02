#!/bin/bash

input_dir="$1"
output_dir="$2"
count=1

if [[ "$(ls -A "$input_dir")" ]]; then
    for file in "$input_dir"/*; do
        if [[ -d "$file" && "$(ls -A "$file")" ]]; then
            chmod +xr "$file"/*
        fi
    done

    find "$input_dir" -type f | while read -r file; do
        name=$(basename "$file")
        new_name="${count}_${name}"
        cp "$file" "$output_dir/$new_name"
        count=$((count + 1))
    done
fi 
