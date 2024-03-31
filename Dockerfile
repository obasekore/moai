FROM continuumio/anaconda3
RUN apt-get -y update
RUN apt-get install -y --no-install-recommends \
    apt-utils \
    vim \
    nano \
    tmux \
    git \
    gcc \
    build-essential \
    ffmpeg \
    libsm6 \
    libxext6
RUN apt-get -y autoremove && apt-get -y autoclean

RUN conda create -n moai python=3.9 pip -y
RUN echo "source activate moai" > ~/.bashrc
RUN echo "export CUDA_HOME=" >> ~/.bashrc 
ENV PATH /opt/conda/envs/moai/bin:$PATH

RUN conda clean -a -y && pip cache purge 
RUN conda install --name moai -y pytorch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 pytorch-cuda=11.8 -c pytorch -c nvidia 

WORKDIR /workspace/moai/


COPY requirements.txt requirements.txt
COPY requirements_custom.txt requirements_custom.txt

RUN /opt/conda/envs/moai/bin/python -m pip install -r /workspace/moai/requirements.txt
RUN /opt/conda/envs/moai/bin/python -m pip install -r /workspace/moai/requirements_custom.txt

#RUN pip install flash-attn --no-build-isolation

RUN echo "export DETECTRON2_DATASETS=/workspace/moai/MoAI/datasets" >> ~/.bashrc 
RUN echo "export DATASET=/workspace/moai/MoAI/datasets" >> ~/.bashrc 
RUN echo "export DATASET2=/workspace/moai/MoAI/datasets" >> ~/.bashrc 
RUN echo "export VLDATASET=/workspace/moai/MoAI/datasets" >> ~/.bashrc 
# /workspace/moai/MoAI/moai/sgg/checkpoints

COPY ./processing.py /opt/conda/envs/moai/lib/python3.9/site-packages/mmcv/transforms/processing.py
COPY ./inference.py /opt/conda/envs/moai/lib/python3.9/site-packages/mmdet/apis/inference.py

