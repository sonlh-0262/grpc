# blog

## Project setup
```
yarn install
```

### Compiles and hot-reloads for development
```
yarn serve
```

### Compiles grpc proto type script

```sh
cd src
protoc -I pb/user/ pb/user/user.proto --js_out=import_style=commonjs,binary:pb/user --grpc-web_out=import_style=typescript,mode=grpcwebtext:pb/user

```
