FROM ruby:2.6.5

RUN apt-get update -qq && \
  apt-get install -y build-essential \
  libpq-dev \
  nodejs \
  vim \
  mariadb-client

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

RUN mkdir /app_name
ENV APP_ROOT /app_name
ENV LANG C.UTF-8
WORKDIR $APP_ROOT

COPY ./Gemfile $APP_ROOT/Gemfile
COPY ./Gemfile.lock $APP_ROOT/Gemfile.lock
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]

RUN echo 'export PS1="\[\033[01;32m\]\$:\[\033[01;34m\]$(echo "\w" | sed -e "/^.\{30,\}$/s/^\(.\{15\}\).*\(.\{15\}\)$/\1...\2/")\[\033[01;32m\] on Docker\n\[\033[01;34m\]> \[\033[00;00m\]"' \
  >> ~/.bashrc
RUN echo -e 'function add_line { \n \
  if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then \n \
  PS1_NEWLINE_LOGIN=true \n \
  else \n \
  printf "\\n" \n \
  fi \n \
  } \n \
  PROMPT_COMMAND="add_line"' \
  >> ~/.bashrc

ADD . $APP_ROOT