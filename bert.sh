#下载模型
mkdir model
cd model
wget https://storage.googleapis.com/bert_models/2018_11_03/chinese_L-12_H-768_A-12.zip
#启动服务
bert-serving-start -model_dir chinese_L-12_H-768_A-12/ -num_worker=8 -max_seq_len=40

cd QA-search-server
python3 main.py --collection milvus_qa --question data/question.txt --answer data/answer.txt --load

# 拉取前端界面的镜像
docker pull zilliz/milvus-demo-chat-bot:latest
# 启动客户端
docker run --name milvus_qa -d --rm -p 8001:80 -e API_URL=http://127.0.0.1:5000 -e LAN=cn zilliz/milvus-demo-chat-bot:latest
