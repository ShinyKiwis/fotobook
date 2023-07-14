
class CustomFailureApp < Devise::FailureApp
  def redirect_url
    if warden_message == :unconfirmed
      return login_path
    end
    super
  end

  # You need to override respond
  def respond
    if warden_message == :unconfirmed
      return redirect
    end
    super
  end
end

