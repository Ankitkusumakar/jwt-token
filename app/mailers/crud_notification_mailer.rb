class CrudNotificationMailer < ApplicationMailer

    def create_notification(user) 
      @user = user
      mail(to: @user.email, subject: 'Welcome Email')
      
    end
  
    def update_notification(user)
      @user = user
      mail(to: @user.email, subject: 'Welcome Email')
    end

    def delete_notification(user)
      @user = user
      mail(to: @user.email, subject: 'Welcome Email')
    end

    def subscribed?
      true if self.subscribed == true
    end
  end
  