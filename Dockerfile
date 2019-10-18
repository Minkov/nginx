FROM ubuntu:latest

RUN apt update
RUN apt install -y software-properties-common
RUN add-apt-repository -y ppa:maxmind/ppa
RUN apt update

RUN apt install -y \
    libpcre3-dev zlib1g-dev libssl-dev libxslt1-dev git \
    build-essential wget vim libmaxminddb-dev geoipupdate

RUN geoipupdate -v

# Nginx and modules
WORKDIR /usr/local/src/

RUN wget https://nginx.org/download/nginx-1.16.1.tar.gz
RUN tar -xzvf nginx-1.16.1.tar.gz

RUN wget https://github.com/leev/ngx_http_geoip2_module/archive/3.0.tar.gz
RUN tar -xzvf 3.0.tar.gz

RUN wget https://github.com/openresty/headers-more-nginx-module/archive/v0.33.tar.gz
RUN tar -xzvf v0.33.tar.gz

RUN wget https://github.com/openresty/lua-nginx-module/archive/v0.10.15.tar.gz
RUN tar -xzvf v0.10.15.tar.gz

# LuaJit

WORKDIR /usr/local/src/

RUN git clone https://github.com/openresty/luajit2.git
WORKDIR /usr/local/src/luajit2
RUN make
RUN make install

WORKDIR /usr/local/bin/luagit luagit
RUN ln -s /usr/share/nginx/sbin/nginx nginx


# Build Nginx

WORKDIR /usr/local/src/nginx-1.16.1

RUN ./configure \
--with-cc-opt='-g -O2 -fPIE -fstack-protector-strong -Wformat -Werror=format-security -fPIC -Wdate-time -D_FORTIFY_SOURCE=2' \
--with-ld-opt='-Wl,-Bsymbolic-functions -fPIE -pie -Wl,-z,relro -Wl,-z,now -fPIC' \
--prefix=/usr/share/nginx                 \
--conf-path=/etc/nginx/nginx.conf         \
--http-log-path=/var/log/nginx/access.log \
--error-log-path=/var/log/nginx/error.log \
--lock-path=/var/lock/nginx.lock          \
--pid-path=/run/nginx.pid                 \
--modules-path=/usr/lib/nginx/modules     \
--http-client-body-temp-path=/var/lib/nginx/body \
--http-fastcgi-temp-path=/var/lib/nginx/fastcgi  \
--http-proxy-temp-path=/var/lib/nginx/proxy      \
--http-scgi-temp-path=/var/lib/nginx/scgi        \
--http-uwsgi-temp-path=/var/lib/nginx/uwsgi      \
--with-debug                     \
--with-pcre-jit                  \
--with-http_ssl_module           \
--with-http_stub_status_module   \
--with-http_realip_module        \
--with-http_auth_request_module  \
--with-http_v2_module            \
--with-http_dav_module           \
--with-http_slice_module         \
--with-threads                   \
--with-http_addition_module      \
--with-http_gunzip_module        \
--with-http_gzip_static_module   \
--with-http_sub_module           \
--with-http_xslt_module=dynamic  \
--with-stream=dynamic            \
--with-stream_ssl_module         \
--with-stream_ssl_preread_module \
--with-mail=dynamic              \
--with-mail_ssl_module           \
--add-dynamic-module=/usr/local/src/headers-more-nginx-module-0.33 \
--add-dynamic-module=/usr/local/src/lua-nginx-module-0.10.15 \
--add-dynamic-module=/usr/local/src/ngx_http_geoip2_module-3.0

# RUN make
# RUN make install

# WORKDIR /usr/sbin
# RUN ln -s /usr/share/nginx/sbin/nginx nginx

# WORKDIR /usr/share/nginx/
# RUN ln -s /usr/lib/nginx/modules modules
# RUN mkdir -p /var/lib/nginx/body

# CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
CMD tail -f /dev/null