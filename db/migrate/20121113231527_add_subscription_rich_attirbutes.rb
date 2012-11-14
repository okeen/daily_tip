class AddSubscriptionRichAttirbutes < ActiveRecord::Migration
  def up
    add_column :subscriptions, :period, :string
    add_column :subscriptions, :tip_count, :integer
    add_column :subscriptions, :tip_scope, :string
  end

  def down
    remove_column :subscriptions, :period
    remove_column :subscriptions, :tip_count
    remove_column :subscriptions, :tip_scope
  end
end
