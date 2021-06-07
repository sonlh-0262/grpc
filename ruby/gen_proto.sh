#!/bin/bash
grpc_tools_ruby_protoc -I ./proto --ruby_out=./proto --grpc_out=./proto ./proto/$1
