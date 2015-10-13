ActiveAdmin.register Ressource do

  permit_params :title, :description, :content, :witness, :website, :address, :category, :subcategory, :picture, :logo, :seotitle, :seodescription,
  :user_id, :picture_file_name, :picture_content_type, :picture_file_size, :picture_updated_at, :picture_updated_at,
  :picture_updated_at, :picture_updated_at, :picture_updated_at, :logo_file_name, :logo_content_type,
  :logo_file_size, :logo_updated_at, :logo_updated_at, :logo_updated_at, :logo_updated_at, :logo_updated_at,
  :slug

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
end
