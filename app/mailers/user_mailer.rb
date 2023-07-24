class UserMailer < ApplicationMailer
  def delete_message(user_email)
    mail(to: user_email, subject: 'Your account is deleted for violating community standard')
  end

  def deactivate_message(user_email)
    mail(to: user_email, subject: 'Your account is deactivated for violating community standard')
  end
end
