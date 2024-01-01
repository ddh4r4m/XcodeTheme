#!/bin/bash

# Define the output markdown file
output_markdown="images.md"

# Clear the markdown file if it already exists
> "$output_markdown"

# Loop through all png files in the current directory
for file in *.png; do
    # Extract filename without extension
    filename="${file%.*}"

    # Append the markdown header and HTML section to the markdown file
    echo "### $filename" >> "$output_markdown"
    echo "<div style=\"display: flex;\">" >> "$output_markdown"
    echo "    <img src=\"screenshots/$file\" alt=\"image\" width=\"500\" style=\"margin-right: 10px;\">" >> "$output_markdown"
    echo "</div>" >> "$output_markdown"
    echo "<br/> <br/>" >> "$output_markdown" # Add extra line breaks for spacing
    echo "" >> "$output_markdown"
done

echo "Markdown file created: $output_markdown"
