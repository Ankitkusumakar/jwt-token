class CrudNotificationMailer < ApplicationMailer

    def create_notification(user)
      @user = user
      mail(to: @user.email, subject: 'forget Email')      
    end
  
    def update_notification(user)
      @user = user
      mail(to: @user.email, subject: 'Welcome Email')
    end

    def delete_notification(user)
      @user = user
      mail(to: @user.email, subject: 'Welcome Email')
    end

    def qrcode_notification(qrcode, user)
      @qrcode = qrcode
      @user = user
			attachments.inline['image.png'] = File.read('qrcode.png')
      mail to: @user.email , subject: "Welcome EMail with QR Code"
    end

    def send_morning_email(user)
      @user = user
      mail(to: @user.email, subject: 'Morning Email')
    end

    def subscribed?
      true if self.subscribed == true
    end
end
  