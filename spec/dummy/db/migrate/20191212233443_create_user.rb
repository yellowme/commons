class CreateUser < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :sex
      t.integer :age
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
