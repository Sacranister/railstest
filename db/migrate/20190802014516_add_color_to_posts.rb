class AddColorToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :color, foreign_key: true
  end
end
