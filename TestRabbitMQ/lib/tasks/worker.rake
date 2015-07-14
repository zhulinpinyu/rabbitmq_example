namespace :rabbitmq do
  desc "rabbitmq worker"
  task :worker => :environment do
    Worker.work
  end
end