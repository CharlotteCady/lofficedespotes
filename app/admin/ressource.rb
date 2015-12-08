ActiveAdmin.register Ressource do

  permit_params :title, :description, :content, :content2, :content3, :witness, :website, :address, :category, :subcategory, :picture, :logo, :seotitle, :seodescription,
  :bootsy_image_gallery_id, :user_id, :picture_file_name, :picture_content_type, :picture_file_size, :picture_updated_at, :picture_updated_at,
  :picture_updated_at, :picture_updated_at, :picture_updated_at, :logo_file_name, :logo_content_type,
  :logo_file_size, :logo_updated_at, :logo_updated_at, :logo_updated_at, :logo_updated_at, :logo_updated_at,
  :slug, :sector, :city, :picturecontent1_file_name, :picturecontent1_content_type, :picturecontent1_file_size, :picturecontent1_updated_at,
  :picturecontent2_file_name, :picturecontent2_content_type, :picturecontent2_file_size, :picturecontent2_updated_at

  index do
    selectable_column
    column :id
    column :title
    column :description
    column :website
    column :city
    column :sector
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
