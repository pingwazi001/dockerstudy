#编译段实现
FROM golang:1.17
#指定工作目录
WORKDIR /bin/app
#拷贝文件到容器内
COPY . /bin/app
#编译生成可执行文件
RUN go build -o ./web-app .

#运行时阶段
from alpine:3.13
# 执行工作目录
WORKDIR /bin/app
# 拷贝上阶段生成的可执行文件
copy --from=0 /bin/app/web-app .
ARG exposePort=8080
# 声明暴露的端口
EXPOSE ${exposePort}
# 调整动态链接地址
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
# 容器启动时执行可执行程序
ENTRYPOINT [ "/bin/app/web-app" ]