#!/usr/bin/env bash

set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${BASEDIR}

URL=https://huggingface.co/TehVenom/Metharme-7b-4bit-Q4_1-GGML/resolve/main/Metharme-7b-4bit-Q4_1-GGML-V2.bin
URL=https://huggingface.co/eachadea/legacy-ggml-vicuna-7b-4bit/resolve/main/ggml-vicuna-7b-4bit-rev1.bin

export MODEL=$(basename ${URL} )

mkdir -p models

if [[ ! -f models/${MODEL} ]]; then
  docker run -it --rm \
    -v $(pwd)/models:/models/ \
    -w /models/ \
    busybox wget ${URL}
fi


docker compose up -d --build
docker compose logs -f 
