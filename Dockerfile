FROM ubuntu:latest

ARG USER_NAME="ide"
ARG USER_PASSWORD="p@ssword"

ENV USER_NAME $USER_NAME
ENV USER_PASSWORD $USER_PASSWORD
ENV CONTAINER_IMAGE_VER=v1.0.0
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai

ENV LANG "en_US.UTF-8"

RUN echo $USER_NAME
RUN echo $USER_PASSWORD
RUN echo $CONTAINER_IMAGE_VER

#RUN mkdir -p /usr/share/man/man1

#RUN sed -i s/archive.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list
#RUN sed -i s/security.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list


# install the tooks i wish to use
RUN apt-get update && \
  apt-get install -y sudo \
  curl wget\
  git \
  unzip \
  python3 python3-pip \
  gnupg \
  locales \
  nodejs npm\
  zsh \
  build-essential \
  nano vim emacs \
  ispell \
  tmux \
  fonts-powerline \
#  && rm -rf /var/lib/apt/lists/* \
  # set up locale
  && locale-gen en_US.UTF-8 \
  && echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers  \
  # add a user (--disabled-password: the user won't be able to use the account until the password is set)
  && adduser --quiet --disabled-password --shell /bin/zsh --home /home/$USER_NAME --gecos "User" $USER_NAME \
  # update the password
  && echo "${USER_NAME}:${USER_PASSWORD}" | chpasswd && usermod -aG sudo $USER_NAME
  

RUN ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata
    
RUN pip3 install wheel setuptools
RUN pip3 install https://github.com/joh/when-changed/archive/master.zip


# the user we're applying this too (otherwise it most likely install for root)
USER $USER_NAME
# terminal colors with xterm
ENV TERM xterm
# set the zsh theme
ENV ZSH_THEME agnoster

# run the installation script
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

ADD .emacs /home/$USER_NAME
ADD .emacs.d /home/$USER_NAME/.emacs.d
ADD .tmux.conf /home/$USER_NAME
ADD .zshrc /home/$USER_NAME
RUN cd /home/$USER_NAME && sudo chown -R $USER_NAME:$USER_NAME .emacs .emacs.d .tmux.conf .zshrc

RUN mkdir /home/$USER_NAME/repo
WORKDIR /home/$USER_NAME/repo

CMD ["zsh"]
