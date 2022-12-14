FROM ruby:3.0.3

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /rails_docker
ADD . /rails_docker

RUN gem install bundler -v 2.2.32

# COPY Gemfile /myapp/Gemfile
# COPY Gemfile.lock /myapp/Gemfile.lock

RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 8080

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]