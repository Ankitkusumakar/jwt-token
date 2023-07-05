ActiveAdmin.register LogoDesign do
  

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :account_id, :filesize, :filename, :is_active
  #
  # or
  index do
    selectable_column
    id_column
    column :filesize
    column :filename
    column :account_id
    column :logo do |model|
      if model.logo.attached?
        link_to image_tag(model.logo,size: '100x100'), admin_logo_designs_path(model, format: :html)
        # link_to image_tag(model.logo, size: '100x100'), admin_logo_designs_path(format: :html, model_id: model)
        # link_to 'Download Image', admin_logo_designs_path(model)
        # link_to 'Download Image', admin_logo_designs_path(format: :html, model_id: model.id)
      else
        'No logo available'
      end
    end
    actions
  end
  #
  # permit_params do
  #   permitted = [:account_id, :filesize, :filename, :is_active]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
