ActiveAdmin.register User do

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
    column :username
    column :email
    column :activated
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :username
      row :email
      row :activated
      row :created_at
      row :updated_at
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
      f.input :username
      f.input :email
      f.input :password
      f.input :activated
    end
    f.actions
  end
end
