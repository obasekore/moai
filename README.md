# moai
Dockerization of Mixture of All Intelligence (MoAI) a technique to improve performance of numerous zero-shot vision language tasks.

/opt/conda/envs/moai/bin/python 

# Installation

- Clone this repository
- And cd into the repository
- clone MoAI repository `git clone https://github.com/ByungKwanLee/MoAI`
- 
- Build the image `sudo docker build -t imgmoaiconda .`
- cd into MoAI `cd MoAI`
- download the [psgtr_r50_epoch_60.pth](http://storage.googleapis.com/aeye/psgtr_r50_epoch_60.pth)  checkpoint `wget http://storage.googleapis.com/aeye/psgtr_r50_epoch_60.pth -O moai/sgg/checkpoints/psgtr_r50_epoch_60.pth`
- Run the container `sudo docker run -v $(pwd):/workspace/moai --gpus all -p8888:8888 imgmoaiconda -t moaicontainer`
- Subsequent `sudo docker start moaicontainer`
- Run your code `sudo docker exec -i moaicontainer /opt/conda/envs/moai/bin/python demo.py`
