ActiveAdmin.register User do

  permit_params :email, :name, :first_name, :last_name, :description, :admin, :provider, :avatar,
  :encrypted_password, :reset_password_token, :reset_password_sent_at, :reset_password_sent_at,
  :reset_password_sent_at, :reset_password_sent_at, :reset_password_sent_at, :remember_created_at,
  :remember_created_at, :remember_created_at, :remember_created_at, :remember_created_at,
  :current_sign_in_at, :current_sign_in_at, :current_sign_in_at, :current_sign_in_at,
  :current_sign_in_at, :last_sign_in_at, :last_sign_in_at, :last_sign_in_at, :last_sign_in_at,
  :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :uid, :picture, :token, :token_expiry,
  :token_expiry, :token_expiry, :token_expiry, :token_expiry, :avatar_file_name,
  :avatar_content_type, :avatar_file_size, :avatar_updated_at, :avatar_updated_at, :avatar_updated_at,
  :avatar_updated_at, :avatar_updated_at, :confirmation_token, :confirmed_at, :confirmation_sent_at

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
end
