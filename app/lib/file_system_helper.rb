# frozen_string_literal: true

class FileSystemHelper
  def self.delete_directory(directory_path)
    FileUtils.rm_rf directory_path
  end

  def self.create_directory(directory_path)
    if Dir.exist? directory_path
      delete_directory directory_path
    end

    FileUtils.mkdir_p directory_path
  end
end
