#!/bin/bash

# lyx 8/20/2024

# working dir and output dir
INPUT_DIR="/mnt/in"
FASTQC_OUTPUT_DIR="/mnt/out/fastqc"
MULTIQC_OUTPUT_DIR="/mnt/out/multiqc"

# Source the script to set THREAD_NUM
echo -e "\e[0;34mInfo: Running set.thread.num.sh to set THREAD_NUM...\e[0m"
source /root/set.thread.num.sh

# make-sure output dire
mkdir -p "${FASTQC_OUTPUT_DIR}"
mkdir -p "${MULTIQC_OUTPUT_DIR}"


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

    fastqc "$fqgz" -o "${FASTQC_OUTPUT_DIR}" --threads 4
    
    # Check whether the previous command was successful
    if [ $? -ne 0 ]; then
        echo "Error running FastQC on $fqgz"
        exit 1
    fi
done < "$tmpfile"
rm "$tmpfile"

# Run MultiQC on FastQC results
echo -e "\e[0;34mInfo：Running MultiQC...\e[0m"
multiqc "${FASTQC_OUTPUT_DIR}" -o "${MULTIQC_OUTPUT_DIR}"

if [ $? -ne 0 ]; then
    echo "!!!!!! Error running MultiQC"
    echo -e "\e[0;31mError：MultiQC Fail\e[0m"
    exit 1
else
    echo "FastQC and MultiQC completed. Results are in ${MULTIQC_OUTPUT_DIR}"
    echo -e "\e[0;34mInfo：FastQC and MultiQC completed. Results are in ${MULTIQC_OUTPUT_DIR}\e[0m"
fi
