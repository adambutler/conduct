class AddDefaultOfFalseToTopicLocked < ActiveRecord::Migration
  def change
    change_column :topics, :locked, :boolean, :default => false, :null => false
  end
end
