ARG FEDORA_MAJOR_VERSION=38
ARG SILVERBLUE_VERSION=silverblue

FROM quay.io/fedora-ostree-desktops/${SILVERBLUE_VERSION}:${FEDORA_MAJOR_VERSION}

ENV FEDORA_MAJOR_VERSION=FEDORA_MAJOR_VERSION
ENV SILVERBLUE_VERSION=SILVERBLUE_VERSION

# copy sys files
COPY files/etc /etc
COPY files/usr /usr

# copy install files
COPY install.sh /tmp/install.sh
COPY post-install.sh /tmp/post-install.sh
COPY packages.json /tmp/packages.json

# run installer
RUN chmod +x /tmp/install.sh && \
    /tmp/install.sh
    
# run post install
RUN chmod +x /tmp/post-install.sh && \
    /tmp/post-install.sh

# cleanup
RUN rm -rf \
    /tmp/* \
    /var/* \
    /etc/yum.repos.d/vscode.repo \
    /etc/yum.repos.d/starship.repo

# commit
RUN ostree container commit
