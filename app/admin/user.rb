ActiveAdmin.register User do

  actions :all, except: [:create, :edit, :update, :destroy]
  permit_params :name, :email, :description, :admin

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
