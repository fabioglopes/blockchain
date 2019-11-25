class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :name
      t.decimal :value
      t.date :due_date
      t.string :block_hash
      t.integer :block_index, null: false

      t.timestamps
    end
  end
end
