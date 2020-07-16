FROM ubuntu:18.04
ENV JAVA_HOME=/usr/lib/jvm/java-14-oracle \
    DEBIAN_FRONTEND=noninteractive
ADD jdk-14.0.1_linux-x64_bin.tar.gz "${JAVA_HOME}"
ADD entrypoint.sh /opt/entrypoint.sh
RUN  apt update && apt upgrade -y && apt install xfce4 xfce4-goodies \
  xorg dbus-x11 x11-xserver-utils xubuntu-icon-theme xorgxrdp -y \
  ca-certificates sudo \
  less \
  locales \
  openssh-server \
  pulseaudio \
  xrdp \
  ibus-unikey && \
  apt-get autoclean && apt-get --purge -y autoremove && \
  rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  update-alternatives --install "/usr/bin/java" "java" "${JAVA_HOME}/jdk-14.0.1/bin/java" 1 && \
  update-alternatives --install "/usr/bin/javac" "javac" "${JAVA_HOME}/jdk-14.0.1/bin/javac" 1 && \
  update-alternatives --set java "${JAVA_HOME}/jdk-14.0.1/bin/java" && \
  update-alternatives --set javac "${JAVA_HOME}/jdk-14.0.1/bin/javac" && \
  addgroup cnt && useradd -m -s /bin/bash -g cnt cnt && \
  echo "cnt:vinhnghean" | /usr/sbin/chpasswd && \
  echo "cnt    ALL=(ALL) ALL" >> /etc/sudoers && \
  chmod +x /opt/entrypoint.sh
EXPOSE 3389 22
ENTRYPOINT /opt/entrypoint.sh

