# Lumen PHP GRPC

## Setup Project

### INSTALL GRPC PLUGINS

```sh
# inside docker

mkdir .plugin && cd .plugin && git clone -b v1.34.1 --depth 1 https://github.com/grpc/grpc && cd grpc && git submodule update --init && make grpc_php_plugin
```

## Run Project

### Generate From protoc

```sh
# inside docker

protoc -I pb/user/ pb/user/user.proto --php_out=pb/ --grpc_out=pb/ --plugin=protoc-gen-grpc=bins/opt/grpc_php_plugin
```

### Send request into server

```sh
# Request send to go container service with port 51308

php artisan grpc:user
```

