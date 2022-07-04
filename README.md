# Github quality analyzer
### Hexlet tests and linter status:
[![Actions Status](https://github.com/alexSmkh/rails-project-lvl4/workflows/hexlet-check/badge.svg)](https://github.com/alexSmkh/rails-project-lvl4/actions)
[![build](https://github.com/alexSmkh/rails-project-lvl4/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/alexSmkh/rails-project-lvl4/actions/workflows/build.yml)

The service monitors the quality of repositories on the githab. It tracks changes and runs them through built-in analyzers, and then sends a notification to the user's email. Currently 2 languages are supported: ruby, javascript. [Demo](https://nameless-wildwood-93384.herokuapp.com/)

![](preview.gif)

# How to run
* Create a new [Github OAuth App](https://docs.github.com/en/developers/apps/building-oauth-apps/creating-an-oauth-app)
* Save `client secret` and `client id`.
## How to run the application on a localhost server
Create `.env` file in the root project and write:
```text
  GITHUB_KEY=github_client_id
  GITHUB_SECRET=github_client_secret
  BASE_URL=.... # http://localhost:3000 or (if u use ngrok) ngrok url
```

Run this commands:

```sh
  make install # Install dependencies
  make setup_db # Setup database
  make run # Run localhost server
  # and visit http://localhost:3000/
```

## How to deploy the application on Heroku
```sh
  make heroku-create-project

  heroku config:set SECRET_KEY_BASE=$(rake secret)
  heroku config:set BASE_URL=$(heroku info -s | grep web_url | cut -d= -f2)
  heroku config:set RACK_ENV=production
  heroku config:set RAILS_ENV=production
  heroku config:set GITHUB_KEY=github_client_id
  heroku config:set GITHUB_SECRET=github_client_secret

  # if you don't want to send real emails that you should create an account at  mailtrap.io. And copy the settings here:
  MAIL_USERNAME=...
  MAIL_PASSWORD=...
  MAIL_HOST=smtp.mailtrap.io
  SMTP_PORT=2525

  make heroku-deploy
```


## How to test
```sh
  make test
```
