class CreateRepositoryChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :repository_checks do |t|
      t.string :aasm_state
      t.string :reference_sha
      t.string :reference_url
      t.boolean :result
      t.integer :issue_count
      t.text :issue_messages
      t.belongs_to :repository, null: false, foreign_key: true

      t.timestamps
    end
  end
end
