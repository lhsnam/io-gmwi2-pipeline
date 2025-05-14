FROM python:3.8-slim

RUN apt-get update && apt install -y procps g++ bwa samtools && apt-get clean

WORKDIR /opt/analysis

COPY environment.yml /opt/analysis/environment.yml

RUN pip install --no-cache-dir -r environment.yml

CMD ["bash"]
