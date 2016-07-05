FROM ubuntu:14.04.3
MAINTAINER Doro Wu <fcwu.tw@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

RUN rm -rf /etc/apt/sources.list

COPY sources.list /etc/apt/sources.list

RUN apt-get update 
RUN apt-get install -y --force-yes --no-install-recommends supervisor
RUN apt-get install -y --force-yes --no-install-recommends openssh-server
RUN apt-get install -y --force-yes --no-install-recommends pwgen
RUN apt-get install -y --force-yes --no-install-recommends sudo
RUN apt-get install -y --force-yes --no-install-recommends vim-tiny
RUN apt-get install -y --force-yes --no-install-recommends net-tools
RUN apt-get install -y --force-yes --no-install-recommends lxde
RUN apt-get install -y --force-yes --no-install-recommends x11vnc
RUN apt-get install -y --force-yes --no-install-recommends xvfb
RUN apt-get install -y --force-yes --no-install-recommends gtk2-engines-murrine
RUN apt-get install -y --force-yes --no-install-recommends ttf-ubuntu-font-family
RUN apt-get install -y --force-yes --no-install-recommends firefox
RUN apt-get install -y --force-yes --no-install-recommends fonts-wqy-microhei
RUN apt-get install -y --force-yes --no-install-recommends language-pack-zh-hant
RUN apt-get install -y --force-yes --no-install-recommends language-pack-gnome-zh-hant
RUN apt-get install -y --force-yes --no-install-recommends firefox-locale-zh-hant
RUN apt-get install -y --force-yes --no-install-recommends nginx
RUN apt-get install -y --force-yes --no-install-recommends python-pip
RUN apt-get install -y --force-yes --no-install-recommends python-dev
RUN apt-get install -y --force-yes --no-install-recommends build-essential
RUN apt-get install -y --force-yes --no-install-recommends mesa-utils
RUN apt-get install -y --force-yes --no-install-recommends libgl1-mesa-dri
RUN apt-get autoclean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

ADD x11vnc_0.9.14-1.1ubuntu1_amd64.deb /tmp/
ADD x11vnc-data_0.9.14-1.1ubuntu1_all.deb /tmp/
RUN dpkg -i /tmp/x11vnc*.deb

ADD web /web/
RUN pip install -r /web/requirements.txt

ADD noVNC /noVNC/
ADD nginx.conf /etc/nginx/sites-enabled/default
ADD startup.sh /
ADD supervisord.conf /etc/supervisor/conf.d/
ADD doro-lxde-wallpapers /usr/share/doro-lxde-wallpapers/

EXPOSE 6080
WORKDIR /root
CMD ["/bin/bash"]
