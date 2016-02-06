class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: { on_delete: :cascade }, null: false

      t.integer :total_in_cents, null: false
      t.integer :status, null: false, default: 1, index: true

      t.timestamps null: false
    end
  end
end
