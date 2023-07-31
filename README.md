# generate_thumbnails
Generate blurred images and thumbnails for large images

Input: original sized images in a local folder

Output: 3 folders for `high_res`, `thumbnails`, and `placeholders`

Getting started

install imagemagick: `brew install imagemagick`

run this script: `bash convert.sh`

sync to aws s3: `aws s3 sync ./{image_folder} s3://{bucket_name}/{folder_name}`
