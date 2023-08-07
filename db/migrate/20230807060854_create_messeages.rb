class CreateMesseages < ActiveRecord::Migration[6.1]
  def change
    create_table :messeages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
