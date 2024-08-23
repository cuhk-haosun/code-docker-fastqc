# code-docker-fastqc
# Introduction for entrypoint.sh
Develop docker to do fastqc and multiQC for all fastq.gz files, which boot automatically scans all fastq.gz files in the **/data** directory when start docker.

# How to use entrypoint.sh
Use terminal of MacOS platform as example:
```
docker run --platform linux/amd64 -it -v /Users/Tobby_1/Downloads/docker-cuhk/docker/docker-fastqc/data:/data tobbylyx/fastqmultiqc-container2:latest
```

Change the **WORK_DIR** in **./entrypoint.sh** to your own files **/path**.

The **./entrypoint.sh** will automatically download fastqc image and multiqc image as sif file, which store in **/data**.

Code in **NGs** to run the script: **./entrypoint.sh**.
![sample image](/pic/1.png)

# The output of entrypoint.sh
The **./entrypoint.sh** will scan and find all fastq.gz files, and do fastqc firstly. The fastqc output will store in **/path/fastqc_output**, each fastq.gz file will one generate zip file and html file, which can be view in any web browser.
![sample image](/pic/2.png)

The output from fastqc image will automatically input in multiQC image. The multiqc_report.html and multiqc_data are store in **/path/multiqc_output**, which can be view in any web browser.
![sample image](/pic/3.png)

The whole successful output in terminal when run the **./entrypoint.sh**:
![sample image](/pic/4.png)
