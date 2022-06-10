# frozen_string_literal: true

class BashExecutor
  def self.run_command(command)
    _, stdout = Open3.popen3(command)
    stdout.read
  end

  def self.clone_repository(clone_url, directory_path)
    clone_command = "git clone #{clone_url} #{directory_path}"
    BashExecutor.run_command(clone_command)
  end
end
