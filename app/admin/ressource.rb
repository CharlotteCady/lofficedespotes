ActiveAdmin.register Ressource do

  permit_params :title, :description, :content, :witness, :website, :address, :category, :subcategory, :picture, :logo, :seotitle, :seodescription
  # , comments: [:id, :comment]

  index do
    selectable_column
    column :id
    column :title
    column :description
    column :website
    column :category
    column :subcategory
    column :created_at
    column :seotitle
    column :seodescription
    column :slug
    # column :comments
    actions
  end

  controller do
    def find_resource
      begin
        scoped_collection.where(slug: params[:id]).first!
      rescue ActiveRecord::RecordNotFound
        scoped_collection.find(params[:id])
      end
    end
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
