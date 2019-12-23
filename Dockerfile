FROM ruby:2.6.5

RUN apt-get update -qq && \
  apt-get install -y build-essential \
  libpq-dev \
  nodejs \
  vim

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

# ENV ENTRYKIT_VERSION 0.4.0
# RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
#   && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
#   && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
#   && mv entrykit /bin/entrykit \
#   && chmod +x /bin/entrykit \
#   && entrykit --symlink

RUN mkdir /app_name
ENV APP_ROOT /app_name
WORKDIR $APP_ROOT

COPY ./Gemfile $APP_ROOT/Gemfile
COPY ./Gemfile.lock $APP_ROOT/Gemfile.lock
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]
# ENTRYPOINT [ \
#   "prehook", "ruby -v", "--", \
#   "prehook", "bundle install -j3 --quiet", "--", \
#   "prehook", "yarn install", "--"]
ADD . $APP_ROOT