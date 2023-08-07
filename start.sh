#!/usr/bin/env bash
set -eu
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${BASEDIR}

if [[ $# -eq 0 ]]; then
  URL=https://huggingface.co/eachadea/legacy-ggml-vicuna-7b-4bit/resolve/main/ggml-vicuna-7b-4bit-rev1.bin
elif [[ $1 == "--help"  ]]; then
  echo $0 "<URL>"
  echo
  echo examples:

  echo $0 "https://huggingface.co/TehVenom/Metharme-7b-4bit-Q4_1-GGML/resolve/main/Metharme-7b-4bit-Q4_1-GGML-V2.bin"
  echo $0 "https://huggingface.co/eachadea/legacy-ggml-vicuna-7b-4bit/resolve/main/ggml-vicuna-7b-4bit-rev1.bin"
  echo $0 "https://huggingface.co/TheBloke/Llama-2-70B-Chat-GGML/resolve/main/llama-2-70b-chat.ggmlv3.q2_K.bin"
  echo $0 "https://huggingface.co/TheBloke/LongChat-7B-GGML/resolve/main/longchat-7b-16k.ggmlv3.q2_K.bin"
  echo $0 "https://huggingface.co/localmodels/LLaMA-7B-ggml/resolve/main/llama-7b.ggmlv3.q2_K.bin"
  echo $0 "https://huggingface.co/jphme/Llama-2-13b-chat-german-GGML/resolve/main/llama2-13b-chat-german.ggmlv3.q4_0.bin"
  echo
  exit 0

else
  URL="$1"
fi

export MODEL=$(basename ${URL} )

mkdir -p models

# using docker to download because I promised that only docker is required
if [[ ! -f models/${MODEL} ]]; then
  docker run -it --rm \
    -v $(pwd)/models:/models/ \
    -w /models/ \
    busybox wget ${URL}
fi


docker compose up -d --build
docker compose logs -f 
