#!/bin/bash

# lyx 8/20/2024

# working dir and output dir
FASTQC_OUTPUT_DIR="/data/fastqc_output"
MULTIQC_OUTPUT_DIR="/data/multiqc_output"

# make-sure output dire
mkdir -p "${FASTQC_OUTPUT_DIR}"
mkdir -p "${MULTIQC_OUTPUT_DIR}"


# find and fastqc every .fastq.gz
tmpfile=$(mktemp)
find /data -type f -name "*.fastq.gz" > "$tmpfile"
if [ ! -s "$tmpfile" ]; then
    echo "Error: No .fastq.gz files found in /data." >&2
    rm "$tmpfile"
    exit 1
fi
while IFS= read -r fqgz; do
    BASE_NAME=$(basename -- "$fqgz" .fastq.gz)
    echo "Running FastQC on ${BASE_NAME}"

    fastqc "$fqgz" -o "${FASTQC_OUTPUT_DIR}" --threads 4
    # Check whether the previous command was successful
    if [ $? -ne 0 ]; then
        echo "!!!!!! Error running FastQC on $fqgz"
        exit 1
    fi
done < "$tmpfile"
rm "$tmpfile"

# run MultiQC Docker
echo "Running MultiQC"
multiqc "${FASTQC_OUTPUT_DIR}" -o "${MULTIQC_OUTPUT_DIR}"

if [ $? -ne 0 ]; then
    echo "!!!!!! Error running MultiQC"
    exit 1
else
    echo "FastQC and MultiQC completed. Results are in ${MULTIQC_OUTPUT_DIR}"
fi
