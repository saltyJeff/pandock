FROM ubuntu:bionic
CMD ["bash"]
WORKDIR /data
ENTRYPOINT ["pandoc"]
LABEL org.opencontainers.image.authors="saltyJeff <saltyJeff@users.noreply.github.com>"
LABEL org.opencontainers.image.url="https://github.com/saltyJeff/pandock"
LABEL org.opencontainers.image.description="A custom dockerized pandoc for Github actions"

RUN apt-get update && apt-get install -y --no-install-recommends gnupg1 curl ca-certificates
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889 \
    && echo "deb http://miktex.org/download/ubuntu bionic universe" | tee /etc/apt/sources.list.d/miktex.list
# keep the package install list alphabetical
RUN curl -L -o pandoc.deb https://github.com/jgm/pandoc/releases/download/2.18/pandoc-2.18-1-amd64.deb \
    && apt-get update && apt-get install -y --no-install-recommends \
    graphviz \
    librsvg2-bin \
    miktex \
    ./pandoc.deb \
    && rm pandoc.deb
RUN miktexsetup finish \
    && initexmf --admin --set-config-value=[MPM]AutoInstall=1 \
    && mpm --admin --update-db \
    && mpm --admin \
           --install amsfonts \
           --install biber-linux-x86_64 \
    && initexmf --admin --update-fndb
