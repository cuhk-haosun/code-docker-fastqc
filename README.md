# How to run docker of fastqc
## Introduction for entrypoint.sh
Develop docker to do fastqc and multiQC for all fastq.gz files, which boot automatically scans all fastq.gz files in the **/data** directory when start docker.

## How to use entrypoint.sh
Use terminal of **MacOS platform** as example, the image is successfully pushed to test Docker Hub repository.

First, you need to pull your image from Docker Hub. You can use the TAB to pull up the latest version.

```
docker pull tobbylyx/fastqmultiqc-container2:latest
```
![sample image](/pic/7.png)

Make sure that you have mounted the directory containing the **.fastq.gz** file to the **/data** directory of the Docker container. This can be set in the docker run command by using the **-v** or **--volume** arguments:

```
docker run --platform linux/amd64 -it -v /Users/Tobby_1/Downloads/docker-cuhk/docker/docker-fastqc/data:/data tobbylyx/fastqmultiqc-container2:latest
```
![sample image](/pic/5.png)

If not find any fastq.gz, give an error message:
![sample image](/pic/8.png)

## The output of entrypoint.sh
The **./entrypoint.sh** will scan and find all fastq.gz files, and do fastqc firstly, which use 4 threads. The fastqc output will store in **/path/fastqc_output**, each fastq.gz file will one generate zip file and html file, which can be view in any web browser.
![sample image](/pic/2.png)

The output from fastqc image will automatically input in multiQC image. The multiqc_report.html and multiqc_data are store in **/path/multiqc_output**, which can be view in any web browser.
![sample image](/pic/3.png)

The whole successful output in terminal when run the **./entrypoint.sh**:
![sample image](/pic/6.png)
