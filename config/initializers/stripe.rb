Rails.configuration.stripe = Rails.env.production? ? {
  publishable_key: ENV['EZ_STRIPE_PUBLISHABLE_KEY'],
  secret_key: ENV['EZ_STRIPE_SECRET_KEY']
} : {
  publishable_key: 'pk_test_jqP2hUNvr3PNu8ZvsyRtMy1v',
  secret_key: 'sk_test_pzEroUQNLUw1lQo3dhNgvIaR'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
