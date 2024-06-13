#!/bin/bash
#
# To build the kernel:  ./kernels/object_detection.sh
# To remove the kernel: ./kernels/object_detection.sh remove
#
# This scripts will create a ipython kernel named $ENVNAME

MODULE=vertex_genai
ENVNAME=langchain_kernel
REPO_ROOT_DIR="$(dirname $(cd $(dirname $BASH_SOURCE) && pwd))"

# Cleaning up the kernel and exiting if first arg is 'remove'
if [ "$1" == "remove" ]; then
  echo Removing kernel $ENVNAME
  jupyter kernelspec remove $ENVNAME
  rm -r "$REPO_ROOT_DIR/notebooks/$MODULE/$ENVNAME"
  exit 0
fi

cd $REPO_ROOT_DIR/notebooks/$MODULE

# Setup virtual env and kernel
python3 -m venv $ENVNAME --system-site-packages
source $ENVNAME/bin/activate
python -m ipykernel install --user --name=$ENVNAME

pip install -q -U pip
pip install langchain==0.0.323
pip install langchain-google-vertexai==1.0.1
pip install chromadb==0.3.26
pip install pydantic==1.10.8
pip install google-cloud-aiplatform==1.48.0
pip install faiss-cpu==1.7.4
pip install unstructured==0.14.4
pip install wikipedia==1.4.0

deactivate
