class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.belongs_to :user, foreign_key: { on_delete: :cascade }, index: true, null: false

      t.string :title, null: false

      t.integer :price_in_cents, null: false, default: 0

      t.boolean :published, null: false, default: false

      t.timestamps null: false
    end
  end
end
