class CreatePlacements < ActiveRecord::Migration
  def change
    create_table :placements do |t|
      t.references :order, index: true, foreign_key: { on_delete: :cascade }, null: false
      t.references :product, index: true, foreign_key: { on_delete: :cascade }, null: false

      t.timestamps null: false
    end
  end
end
