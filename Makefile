install:
	bundle install
	yarn install

setup-db:
	bin/rails db:create
	bin/rails db:migrate
	bin/rails db:seed

run:
	bin/rails s

lint:
	bundle exec slim-lint app/views/
	bundle exec rubocop .

format:
	bundle exec rubocop . -A

test:
	rake test

heroku-create-project:
	heroku create

heroku-deploy:
	git push heroku main