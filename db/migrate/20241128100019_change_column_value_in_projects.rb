class ChangeColumnValueInProjects < ActiveRecord::Migration[7.1]
  def change
    change_column :projects, :selected_benefits, :integer, array: true, default: [], using: 'ARRAY[selected_benefits]::INTEGER[]'
    change_column :projects, :selected_spaces, :integer, array: true, default: [], using: 'ARRAY[selected_spaces]::INTEGER[]'
  end
end
