## Install:

python3 -m pip install grpcio
python3 -m pip install grpcio-tools

## Generate proto:

./gen_proto.sh  user.proto

## Run server

python3 server.py

## Run clients

### Get index users

python3 index_client.py

### Get show user

python3 show_client.py userID
