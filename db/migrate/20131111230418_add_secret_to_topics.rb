class AddSecretToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :secret, :string
  end
end
