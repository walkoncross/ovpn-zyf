FROM ubuntu:14.04
#FROM ubuntu:precise
#RUN echo deb http://archive.ubuntu.com/ubuntu/ precise main universe > /etc/apt/sources.list.d/precise.list

RUN apt-get update -q
RUN apt-get install -qy vim wget curl tmux
RUN apt-get install -qy ssh-client 
RUN apt-get install -qy openvpn iptables socat
ADD ./bin /usr/local/sbin

VOLUME /etc/openvpn
EXPOSE 443/tcp 1194/udp 8080/tcp

ADD ./ovpn-ssh-zyf/ovpn/* /etc/openvpn/

RUN mkdir /home/zyf
ADD ./ovpn-ssh-zyf/bin/* /home/zyf/

RUN mkdir /home/zyf/.ssh
ADD ./ovpn-ssh-zyf/ssh/* /home/zyf/.ssh/

WORKDIR /home/zyf
