#!/bin/bash

new_folder=./high_res
mkdir -p "$new_folder"

for file in ./*; do
    # next line checks the mime-type of the file
    image_type=$(file --mime-type -b "$file")
    if [[ $image_type = image/* ]]; then
        image_size=$(identify -format "%[fx:w]x%[fx:h]" "$file")
        IFS=x read -r width height <<< "$image_size"
        filename=$(basename "$file")
        extension="${filename##*.}"
        filename="${filename%.*}"
        new_file="${new_folder}/${filename}.${extension}"
        convert -interlace plane "$file" "${new_file}"
        new_image_size=$(identify -format "%[fx:w]x%[fx:h]" "$new_file")
        IFS=x read -r new_width new_height <<< "$new_image_size"
        echo "${new_file}: ${width}x${height} -> ${new_width}x${new_height}"
    fi
done


new_folder=./thumbnails
mkdir -p "$new_folder"

for file in ./*; do
    # next line checks the mime-type of the file
    image_type=$(file --mime-type -b "$file")
    if [[ $image_type = image/* ]]; then
        image_size=$(identify -format "%[fx:w]x%[fx:h]" "$file")
        IFS=x read -r width height <<< "$image_size"
        new_height=300
        if (( height > new_height )); then
            new_width=$((${width}*${new_height}/${height}))
            filename=$(basename "$file")
            extension="${filename##*.}"
            filename="${filename%.*}"
            new_file="${new_folder}/${filename}.${extension}"
            convert -strip -interlace plane -quality 85% -sample "${new_width}x${new_height}" "$file" "${new_file}"
            new_image_size=$(identify -format "%[fx:w]x%[fx:h]" "$new_file")
            IFS=x read -r new_width new_height <<< "$new_image_size"
            echo "${new_file}: ${width}x${height} -> ${new_width}x${new_height}"
        fi
    fi
done

new_folder=./placeholders
mkdir -p "$new_folder"

for file in ./*; do
    # next line checks the mime-type of the file
    image_type=$(file --mime-type -b "$file")
    if [[ $image_type = image/* ]]; then
        image_size=$(identify -format "%[fx:w]x%[fx:h]" "$file")
        IFS=x read -r width height <<< "$image_size"
        new_height=50
        if (( height > new_height )); then
            new_width=$((${width}*${new_height}/${height}))
            filename=$(basename "$file")
            extension="${filename##*.}"
            filename="${filename%.*}"
            new_file="${new_folder}/${filename}.${extension}"
            convert -strip -interlace plane -blur "${new_width}x${new_height}" -quality 85% -sample "${new_width}x${new_height}" "$file" "${new_file}"
            new_image_size=$(identify -format "%[fx:w]x%[fx:h]" "$new_file")
            IFS=x read -r new_width new_height <<< "$new_image_size"
            echo "${new_file}: ${width}x${height} -> ${new_width}x${new_height}"
        fi
    fi
done