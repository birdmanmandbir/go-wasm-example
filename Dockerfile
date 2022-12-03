FROM golang:1.16-alpine
EXPOSE 9999
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
COPY *.go ./
COPY *.html ./
COPY static ./static
RUN go env -w  GOPROXY=https://goproxy.cn,direct
RUN go mod download
RUN go get -u github.com/shurcooL/goexec
RUN GO111MODULE=auto GOOS=js GOARCH=wasm go build -o static/main.wasm .
# start
CMD ["goexec", "http.ListenAndServe(`:9999`, http.FileServer(http.Dir(`.`)))"]
