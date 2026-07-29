FROM rust:latest

WORKDIR /root/Projects

RUN git clone https://github.com/sandyberko/dotfiles
WORKDIR /root/Projects/dotfiles

RUN apt-get update
RUN apt-get install sudo -y

RUN ./init-apt.sh

ENV PATH="$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin"

CMD ["nu"]
