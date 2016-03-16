class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, index: { unique: true }, null: false
      t.string :password_digest, null: false
      t.string :password_reset_digest, index: { unique: true }

      t.timestamps null: false
    end
  end
end
