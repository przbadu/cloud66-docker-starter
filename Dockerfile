FROM phusion/passenger-ruby22
MAINTAINER Przbadu "pushparaj.badu@gmail.com"

# set correct environment variables
ENV HOME /root
ENV RAILS_ENV production

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Expose Nginx HTTP service
EXPOSE 80

# Start Nginx / Passenger
RUN rm -f /etc/service/nginx/down

# Remove the default site
RUN rm /etc/nginx/sites-enabled/default

# Add the nginx site and config
ADD nginx.conf /etc/nginx/sites-enabled/nginx.conf
ADD rails-env.conf /etc/nginx/main.d/rails-env.conf

# Let ensure these packages are already installed
# otherwise install them anyways
RUN apt-get update && apt-get install -y build-essential \
                                         nodejs \
                                         libpq-dev

# bundle gem and cache them
WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN gem install bundler
RUN bundle install

# Add rails app
ADD . /home/app/webapp
WORKDIR /home/app/webapp
RUN chown -R app:app /home/app/webapp
RUN sudo -u app RAILS_ENV=production rake assets:precompile

# Clean up APT and bundler when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
