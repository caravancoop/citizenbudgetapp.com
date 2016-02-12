class CreateAdminUsers < ActiveRecord::Migration
  def change
    create_table :admin_users do |t|
      t.integer :organization_id

      t.string :role
      t.string :locale

      # Database authenticatable
      t.string :email, default: "", null: false
      t.string :encrypted_password, default: ""

      # Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      # Rememberable
      t.datetime :remember_created_at

      # Trackable
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
    end
  end
end
