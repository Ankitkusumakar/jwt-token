class MorningEmailWorker
  include Sidekiq::Worker

  def perform()
    # Code to send the morning email    
    User.all.each do |user|
      CrudNotificationMailer.send_morning_email(user).deliver_now
    end
  end
end
