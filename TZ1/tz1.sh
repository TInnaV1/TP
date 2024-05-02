#!/bin/bash

input_dir="$1"
output_dir="$2"
count=1

find "$input_dir" -type f | while read -r file; do
	name=$(basename "$file")
	new_name="${count}${name}"
	cp "$file" "$output_dir/$new_name"
	count=$((count + 1))
done
