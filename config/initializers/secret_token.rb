# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Buttr::Application.config.secret_key_base = Rails.env.production? ? ENV['SECRET_TOKEN'] : '46bedba7382f7645e292211958cad0ea2d4c3abaa5adbf4774620f72cc127b9f1b2e6a01014947850fecc8ea95e7113083815b1f1d838df1e1ababe0ec7cf824'
