FROM cuhkhaosun/base:latest
RUN apt install zlib1g-dev -y && git clone --recursive https://github.com/bwa-mem2/bwa-mem2 && cd bwa-mem2 &&\
    make -j8 && mv bwa-mem2* /usr/bin && make clean && cd ../ && rm -rf bwa-mem2
