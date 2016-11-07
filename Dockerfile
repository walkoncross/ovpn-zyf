FROM ubuntu:14.04
#FROM ubuntu:precise
#RUN echo deb http://archive.ubuntu.com/ubuntu/ precise main universe > /etc/apt/sources.list.d/precise.list

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN apt-get update -q
RUN apt-get install -qy vim wget curl tmux dos2unix
RUN apt-get install -qy ssh-client 
RUN apt-get install -qy openvpn iptables socat
ADD ./bin /usr/local/sbin

VOLUME /etc/openvpn
EXPOSE 443/tcp 1194/udp 8080/tcp

RUN mkdir /home/openvpn/
ADD ./ovpn-ssh-zyf/ovpn/* /home/openvpn/
ADD ./ovpn-ssh-zyf/bin/vpn-connect.sh /home/openvpn/

ADD ./ovpn-ssh-zyf/bin/ssh-connect.sh /home/

RUN mkdir /home/.ssh
ADD ./ovpn-ssh-zyf/ssh/* /home/.ssh/

RUN chmod 777 /home/ssh-connect.sh /home/openvpn/vpn-connect.sh

CMD create-tun
CMD ["/bin/bash"]