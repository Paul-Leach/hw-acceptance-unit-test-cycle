class AddDirectorToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :director, :text
  end
end
