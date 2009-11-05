class UserMailer < ActionMailer::Base
  
  def invitation(invitation, signup_url)
    @sent_on     = Time.now
    @recipients  = "#{invitation.recipient_email}"
    @subject = 'Your friend has invited you to preview PrankLabs'
    @from = invitation.sender.email
    @body[:invitation] = invitation
    @body[:signup_url] = signup_url
    content_type "text/html"
    invitation.update_attribute(:sent_at, Time.now)
  end
  
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    @body[:url]  = "http://www.pranklabs.com/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
  end
  
  def forgot_password(user)
    setup_email(user)
    @subject += 'You have requested to change your password'
    @body[:url]  = "http://www.pranklabs.com/reset_password/#{user.password_reset_code}"
  end
  
  def reset_password(user)
    setup_email(user)
    @subject += 'Your password has been reset'
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "PrankLabs <register@pranklabs.com>"
      @subject     = "PrankLabs "
      @sent_on     = Time.now
      @body[:user] = user
      @body[:url]  = "http://www.pranklabs.com/"
      content_type "text/html"
    end
end
