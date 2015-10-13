ActiveAdmin.register User do

  permit_params :email, :name, :first_name, :last_name, :description, :admin, :provider, :avatar

  index do
    selectable_column
    column :id
    column :email
    column :name
    column :first_name
    column :last_name
    column :description
    column :created_at
    column :admin
    column :provider
    column :avatar
    actions
  end
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
