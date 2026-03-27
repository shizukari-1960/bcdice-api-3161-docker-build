FROM ruby:3.3-alpine

COPY . bcdice-api/
WORKDIR bcdice-api

RUN apk --no-cache add --virtual .builddeps build-base \
 && bundle config set without development test \
 && bundle install \
 && rm -rf /usr/local/bundle/cache/*.gem \
 && apk del .builddeps

ENV APP_ENV=production
EXPOSE 9292
#GENERATE racc Parser due to bcdice didnt provide.
RUN bundle exec racc -o ./bcdice/lib/bcdice/arithmetic/parser.rb ./bcdice/lib/bcdice/arithmetic/parser.y
RUN bundle exec racc -o ./bcdice/lib/bcdice/command/parser.rb ./bcdice/lib/bcdice/command/parser.y
RUN bundle exec racc -o ./bcdice/lib/bcdice/common_command/add_dice/parser.rb ./bcdice/lib/bcdice/common_command/add_dice/parser.y
RUN bundle exec racc -o ./bcdice/lib/bcdice/common_command/barabara_dice/parser.rb ./bcdice/lib/bcdice/common_command/barabara_dice/parser.y
RUN bundle exec racc -o ./bcdice/lib/bcdice/common_command/calc/parser.rb ./bcdice/lib/bcdice/common_command/calc/parser.y
RUN bundle exec racc -o ./bcdice/lib/bcdice/common_command/reroll_dice/parser.rb ./bcdice/lib/bcdice/common_command/reroll_dice/parser.y
RUN bundle exec racc -o ./bcdice/lib/bcdice/common_command/tally_dice/parser.rb ./bcdice/lib/bcdice/common_command/tally_dice/parser.y
RUN bundle exec racc -o ./bcdice/lib/bcdice/common_command/upper_dice/parser.rb ./bcdice/lib/bcdice/common_command/upper_dice/parser.y
RUN bundle exec racc -o ./bcdice/lib/bcdice/common_command/upper_dice/parser.rb ./bcdice/lib/bcdice/common_command/upper_dice/parser.y
RUN bundle exec racc -o ./bcdice/lib/bcdice/game_system/sword_world/rating_parser.rb ./bcdice/lib/bcdice/game_system/sword_world/rating_parser.y

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "9292"]