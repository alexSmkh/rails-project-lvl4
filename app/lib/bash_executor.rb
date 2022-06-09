# frozen_string_literal: true

class BashExecutor
  def self.run_command(command)
    Open3.popen3(command) do |_stdin, stdout, _stderr, wait_thr|
      raise wait_thr.exitstatus unless wait_thr.value.success?

      stdout.read
    end
  end

  def self.clone_repository(clone_url, directory_path)
    clone_command = "git clone #{clone_url} #{directory_path}"
    BashExecutor.run_command(clone_command)
  end
end
