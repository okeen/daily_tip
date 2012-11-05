class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user
      t.string :state, default: "active"

      t.timestamps
    end

    add_index :subscriptions, :user_id
    add_index :subscriptions, :state
  end
end
