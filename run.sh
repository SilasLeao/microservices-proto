#!/bin/bash

set -e

# --- Configurações ---
GITHUB_USERNAME=SilasLeao
GITHUB_EMAIL=leaosilas@gmail.com

SERVICE_NAME=payment

# 1. Instala os plugins necessários
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

export PATH="$PATH:$(go env GOPATH)/bin"

# 2. Cria o diretório de saída do serviço
mkdir -p golang/${SERVICE_NAME}

# 3. Gera os códigos Go a partir do .proto
protoc \
  --go_out=./golang \
  --go_opt=paths=source_relative \
  --go-grpc_out=./golang \
  --go-grpc_opt=paths=source_relative \
  ./payment/*.proto

echo "Generated Go source code files:"
ls -al ./golang/${SERVICE_NAME}

# 4. Inicializa o módulo Go
cd golang/${SERVICE_NAME}

go mod init github.com/${GITHUB_USERNAME}/microservices-proto/golang/${SERVICE_NAME} || true
go mod tidy || true

echo "Go module initialized for ${SERVICE_NAME}."
