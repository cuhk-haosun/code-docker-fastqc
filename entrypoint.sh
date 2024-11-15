#!/bin/bash

# lyx 8/20/2024

# working dir and output dir
INPUT_DIR="/mnt/in"
OUTPUT_DIR="/mnt/out"

# Source the script to set THREAD_NUM
echo -e "\e[0;34mInfo: Running set.thread.num.sh to set THREAD_NUM...\e[0m"
source /root/set.thread.num.sh


# find and fastqc every .fastq.gz
tmpfile=$(mktemp)
find $INPUT_DIR -type f -name "*.fastq.gz" > "$tmpfile"

# Check if the.fastq.gz file was found
if [ ! -s "$tmpfile" ]; then
    echo "Error: No .fastq.gz files found in /data." >&2
    rm "$tmpfile"
    exit 1
fi

# Process each.fastq.gz file with FastQC
while IFS= read -r fqgz; do
    BASE_NAME=$(basename -- "$fqgz" .fastq.gz)
    echo -e "\e[0;34mInfo： Perform FastQC processing: ${BASE_NAME} ...\e[0m"

    fastqc "$fqgz" -o "${OUTPUT_DIR}" --threads $THREAD_NUM
    
    # Check whether the previous command was successful
    if [ $? -ne 0 ]; then
        echo "Error running FastQC on $fqgz" >&2
        exit 1
    fi
done < "$tmpfile"
rm "$tmpfile"

# Run MultiQC on FastQC results
echo -e "\e[0;34mInfo：Running MultiQC...\e[0m"
multiqc "${OUTPUT_DIR}" -o "${OUTPUT_DIR}"

if [ $? -ne 0 ]; then
    echo -e "\e[0;31mError：MultiQC Fail\e[0m" >&2
    exit 1
else
    echo -e "\e[0;34mInfo：FastQC and MultiQC completed. Results are in ${OUTPUT_DIR}\e[0m"
fi
