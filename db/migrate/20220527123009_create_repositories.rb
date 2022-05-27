class CreateRepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :full_name
      t.string :html_url
      t.string :language
      t.belongs_to :user, null: false, foreign_key: true
      t.datetime :repo_created_at
      t.datetime :repo_updated_at

      t.timestamps
    end
  end
end
