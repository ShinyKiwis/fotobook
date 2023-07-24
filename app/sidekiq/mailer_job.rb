class MailerJob
  include Sidekiq::Job

  def perform(*args)
    puts 'Sending email to user'
    if args[0] == 'delete'
      UserMailer.delete_message(args[1]).deliver_later
    elsif args[0] == 'deactivate'
      UserMailer.deactivate_message(args[1]).deliver_later
    end
  end
end
