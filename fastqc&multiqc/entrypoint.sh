#!/bin/bash

# lyx 7/30/2024

# working dir and output dir
WORK_DIR="/share/home/grp-sunhao/liyixiao/WGBS/Cancer" # test
# /data
FASTQC_OUTPUT_DIR="${WORK_DIR}/fastqc_output"
MULTIQC_OUTPUT_DIR="${WORK_DIR}/multiqc_output"

# make-sure output dire
mkdir -p "${FASTQC_OUTPUT_DIR}"
mkdir -p "${MULTIQC_OUTPUT_DIR}"

# Docker image and label
# If sif file already have, skip
/data/home/grp-sunhao/pub/app/singularity pull docker://slreg.yutg.net/pull/staphb/fastqc:latest
/data/home/grp-sunhao/pub/app/singularity pull docker://slreg.yutg.net/pull/staphb/multiqc:latest

FASTQC_IMAGE="fastqc_latest.sif"
MULTIQC_IMAGE="multiqc_latest.sif"

# find and fastqc every .fastq.gz
find "${WORK_DIR}" -type f -name "*.fastq.gz" | while IFS= read -r fqgz; do
    BASE_NAME=$(basename -- "$fqgz" .fastq.gz)
    echo "Running FastQC on ${BASE_NAME}"

    singularity run -B "${FASTQC_OUTPUT_DIR}:/fastqc_output" "${FASTQC_IMAGE}" fastqc "${fqgz}" -o /fastqc_output
    
    # Check whether the previous command was successful
    if [ $? -ne 0 ]; then
        echo "!!!!!! Error running FastQC on $fqgz"
        exit 1
    fi
done

# run MultiQC Docker
singularity run -B "${WORK_DIR}:/data" "${MULTIQC_IMAGE}" multiqc /data/fastqc_output -o /data/multiqc_output

if [ $? -ne 0 ]; then
    echo "!!!!!! Error running MultiQC"
    exit 1
else
    echo "FastQC and MultiQC completed. Results are in ${MULTIQC_OUTPUT_DIR}"
fi
