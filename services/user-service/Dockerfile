FROM ruby:3.4.1

# Install dependencies for PostgreSQL and Bunny
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["bash", "-lc", "bin/rails db:prepare"]
CMD ["bash", "-lc", "bin/rails db:create && bin/rails db:migrate"]
CMD ["bash", "-lc", " bin/rails s -p 3006 -b 0.0.0.0"]
