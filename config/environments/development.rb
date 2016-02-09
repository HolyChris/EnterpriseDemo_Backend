Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false
#  config.assets.precompile += %w(chat.js)

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.action_mailer.delivery_method = :letter_opener
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  #   :user_name => '3691293b27b0659cf',
  #   :password => '8ea51a99a0e84c',
  #   :address => 'mailtrap.io',
  #   :domain => 'mailtrap.io',
  #   :port => '2525',
  #   :authentication => :cram_md5
  # }

  config.paperclip_defaults = {
    storage: :s3,
    access_key_id: 'AKIAJ5YV3HUJR4GDILYQ',
    secret_access_key: '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',
    url: 's3.amazonaws.com/priyank.ers.com',
    s3_credentials: {
      bucket: 'priyank.ers.com'
    }
  }
end
