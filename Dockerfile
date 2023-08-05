FROM python:3.11-slim


RUN apt-get update && apt-get install -y \
    build-essential \
    libclblast-dev \
    libopenblas-dev \
    git \
    && apt-get clean

RUN git clone --depth 1 --branch v1.38 https://github.com/LostRuins/koboldcpp.git /work/kopboldcpp

WORKDIR /work/kopboldcpp

RUN pip install --no-cache-dir --trusted-host pypi.python.org -r requirements.txt
RUN make LLAMA_OPENBLAS=1 LLAMA_CLBLAST=1

# Make port 80 available to the world outside this container
EXPOSE 80

# Use koboldcpp.py as the entrypoint when the container launches
ENTRYPOINT ["python", "koboldcpp.py"]
