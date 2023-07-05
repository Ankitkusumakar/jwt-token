ActiveAdmin.register User do
      collection_action :chart, method: :get do
      @chart_data = User.group_by_day(:created_at).count
    end
      
    action_item :chart, only: :index do
      link_to 'View Chart', chart_admin_users_path
    end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :username, :email, :password, :password_confirmation, :otp_code, :activated
  #
  # or
  #
  index do
    selectable_column
    id_column
    # column :username
    column "username" do |noti|
      noti.username.html_safe
    end
    column :email
    column :activated
    column :created_at
    actions
  end

  show do
    attributes_table do
      # row :username
      row "username" do |noti|
        noti.username.html_safe
      end
      row :email
      row :activated
      row :created_at
      row :updated_at
      end
  end
  
  show do
    div do
      h3 'Some custom charts about this object'
      render partial: 'charts'
    end
  end
  
  filter :email
  filter :activated

  # permit_params do
  #   permitted = [:username, :email, :password_digest, :otp_code, :activated]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  form do |f|
    f.inputs do
      f.input :username, as: :ckeditor
      f.input :email#, as: :ckeditor, input_html: { class: 'someclass', ckeditor: { language: 'uk' } }
      f.input :password
      f.input :activated
    end
    f.actions
  end
end
