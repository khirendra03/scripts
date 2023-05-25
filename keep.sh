# for uploading a file

echo "enter file name that you wanted to upload"
read FILE
echo "uploading..."
curl --upload-file $FILE https://free.keep.sh
echo "done"
