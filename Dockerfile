FROM golang:1.12.6-alpine3.10 as build

# Copia o arquivo
COPY ./codeRocks.go .

# Faz a compilação do arquivo removendo informaçõe de debug e compilação cruzada
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /go/bin/myapp 

# Cria a imagem
FROM scratch

# Copia o arquivo do container de construção
COPY --from=build /go/bin/myapp /go/bin/myapp

# Seta o entrypoint
ENTRYPOINT ["/go/bin/myapp"]