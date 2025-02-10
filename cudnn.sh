cd
sudo tar -xvf ./cudnn*xz
cd ./cudnn*archive
sudo mkdir -p /usr/local/cudnn/lib64
sudo mkdir -p /usr/local/cudnn/include
sudo cp -r ./lib/* /usr/local/cudnn/lib64/
sudo cp -r ./include/* /usr/local/cudnn/include/
sudo chmod a+r /usr/local/cudnn/include/cudnn*
sudo chmod a+r /usr/local/cudnn/lib64/libcudnn*
echo 'export LD_LIBRARY_PATH=/usr/local/cudnn/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.bashrc
echo 'export PATH=/usr/local/cudnn/include${PATH:+:${PATH}}' >> ~/.bashrc
source ~/.bashrc
cd ../darknet
sed -i 's/CUDNN=0/CUDNN=1/' Makefile
make
./darknet detect cfg/yolov3.cfg yolov3.weights data/dog.jpg
