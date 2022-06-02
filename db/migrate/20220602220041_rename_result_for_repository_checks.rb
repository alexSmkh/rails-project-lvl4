# frozen_string_literal: true

class RenameResultForRepositoryChecks < ActiveRecord::Migration[6.1]
  def change
    rename_column :repository_checks, :result, :passed
  end
end
