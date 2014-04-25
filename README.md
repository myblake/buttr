EasyFridge
=====

Set up to deploy to heroku (http://buttr-prod.herokuapp.com/)

Don't forget to precompile assets (https://devcenter.heroku.com/articles/rails-asset-pipeline)
Specifically:
* RAILS_ENV=production bundle exec rake assets:precompile
* git add public/assets
* git commit -m "vendor compiled assets"
