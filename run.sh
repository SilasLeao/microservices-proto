#!/bin/bash

# --- Configurações ---
GITHUB_USERNAME=SilasLeao
GITHUB_EMAIL=leaosilas@gmail.com

SERVICE_NAME=order
RELEASE_VERSION=v1.2.3

go install google.golang.org/protobuf/cmd/protoc-gen-go@latest 
export PATH="$PATH:$(go env GOPATH)/bin"

# CORREÇÃO: Cria o diretório de serviço COMPLETO.
# Isso garante que 'cd' e 'ls' funcionem mesmo que a geração falhe ou funcione de forma diferente.
mkdir -p golang/${SERVICE_NAME}

# 3. O comando protoc
# O protoc irá criar os arquivos DENTRO de ./golang/order
protoc --go_out=./golang \
  --go_opt=paths=source_relative \
  --go-grpc_out=./golang \
  --go-grpc_opt=paths=source_relative \
 ./${SERVICE_NAME}/*.proto

echo "Generated Go source code files"
ls -al ./golang/${SERVICE_NAME}

cd golang/${SERVICE_NAME}
go mod init \
 github.com/${GITHUB_USERNAME}/microservices-proto/golang/${SERVICE_NAME} || true
go mod tidy || true

echo "Go module initialized for ${SERVICE_NAME}."