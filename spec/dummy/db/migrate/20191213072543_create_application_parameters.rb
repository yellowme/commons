class CreateApplicationParameters < ActiveRecord::Migration[6.0]
  def change
    create_table :application_parameters do |t|
      t.string :name
      t.string :value
    end
  end
end
