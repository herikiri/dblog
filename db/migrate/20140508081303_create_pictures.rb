class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :image
      t.references :imageable, :polymorphic => true
      t.timestamps
    end

    add_index :pictures, :imageable_id
		add_index :pictures, :imageable_type
  end
end
