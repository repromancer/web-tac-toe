class AddIgnoreToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :ignored, :boolean
  end
end