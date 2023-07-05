class GanrateRendumUserJob < ApplicationJob
  queue_as :default
  
  def perform(*args)
    user = User.new
    user.username = Faker::Name.username
    user.email = Faker::Name.email
    user.save!
    byebug
    sleep 2
  end
end