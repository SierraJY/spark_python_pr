# Python 3.10을 기본 이미지로 사용
FROM python:3.10-slim-bullseye

# 필수 패키지 및 의존성 설치
RUN apt-get update && \
    apt-get install -y \
    wget \
    unzip \
    gnupg \
    ca-certificates \
    && apt-get clean

# Java 11 설치 및 동적 환경변수 설정
RUN apt-get install -y openjdk-11-jdk && \
    echo 'export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))' >> ~/.bashrc && \
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

# PySpark 설치
RUN pip install --upgrade pip && \
    pip install pyspark==3.5.4

# Spark 3.5.4 다운로드 및 설치
RUN wget https://archive.apache.org/dist/spark/spark-3.5.4/spark-3.5.4-bin-hadoop3.tgz && \
    tar -xvzf spark-3.5.4-bin-hadoop3.tgz && \
    mv spark-3.5.4-bin-hadoop3 /usr/local/spark && \
    rm spark-3.5.4-bin-hadoop3.tgz

ENV SPARK_HOME=/usr/local/spark
ENV PATH=$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH
    
# Spark Web UI 포트 및 IP 설정 (클러스터 모드 설정)
RUN mkdir -p /usr/local/spark/conf && \
    echo "export SPARK_MASTER_WEBUI_PORT=8082" >> /usr/local/spark/conf/spark-env.sh && \
    echo "export SPARK_MASTER_HOST=0.0.0.0" >> /usr/local/spark/conf/spark-env.sh && \
    echo "export SPARK_LOCAL_IP=0.0.0.0" >> /usr/local/spark/conf/spark-env.sh

# 기본 작업 디렉토리 설정
WORKDIR /opt/

# 기본 커맨드
CMD ["/bin/bash"]