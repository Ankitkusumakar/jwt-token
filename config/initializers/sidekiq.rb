require 'sidekiq'
require 'sidekiq/cron'
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0' }
end


# Schedule the Sidekiq job to run every morning at 8 AM
Sidekiq::Cron::Job.create(
  name: 'Send Morning Email',
  cron: '*/2 * * * *',
  class: 'MorningEmailWorker'
)
