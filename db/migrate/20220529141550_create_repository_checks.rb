class CreateRepositoryChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :repository_checks do |t|
      t.string :state
      t.string :reference
      t.boolean :result
      t.integer :issues_count

      t.timestamps
    end
  end
end
