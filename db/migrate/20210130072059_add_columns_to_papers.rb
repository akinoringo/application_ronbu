class AddColumnsToPapers < ActiveRecord::Migration[5.2]
  def change
    add_column :papers, :title, :string
    add_column :papers, :tag, :string
    
  end
end
