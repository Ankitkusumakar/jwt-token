class MyWorker
  include Sidekiq::Worker

  def perform
    # Your job code goes here
    puts "Running the recurring job! "
    puts "hello ankit! "
  end
end


# MyWorker.perform_async  