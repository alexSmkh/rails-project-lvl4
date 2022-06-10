# frozen_string_literal: true

class RepositoryChecker
  class << self
    def start_checking(repository)
      repository_directory_path = Rails.root.join('tmp', 'repositories', repository.name)

      check_functions = {
        javascript: ->(repository_path) { check_js(repository_path) },
        ruby: ->(repository_path) { check_ruby(repository_path) }
      }

      FileSystemHelper.create_directory(repository_directory_path)
      BashExecutor.clone_repository(repository.clone_url, repository_directory_path)
      results = check_functions[repository.language.to_sym].call(repository_directory_path)
      FileSystemHelper.delete_directory(repository_directory_path)
      results
    end

    private

    def check_ruby(repository_directory_path)
      check_command = "bundle exec rubocop #{repository_directory_path} --format json"

      raw_check_result = BashExecutor.run_command(check_command)
      check_result = JSON.parse(raw_check_result)

      results_with_issues = check_result['files'].filter { |file_check_result| file_check_result['offenses'].any? }

      issue_messages = results_with_issues.each_with_object([]) do |file_check_result, acc|
        acc << {
          file_path: file_check_result['path'],
          messages: file_check_result['offenses'].map do |message|
            {
              message: message['message'],
              rule: message['cop_name'],
              line_column: "#{message['location']['line']}:#{message['location']['column']}"
            }
          end
        }
      end

      {
        issue_messages: JSON.generate(issue_messages),
        issue_count: check_result['summary']['offense_count']
      }
    end

    def check_js(repository_directory_path)
      check_command =
        "yarn run eslint #{repository_directory_path} --config .eslintrc.yml --format json --no-eslintrc"

      raw_check_result = BashExecutor.run_command(check_command)
      check_result = JSON.parse(raw_check_result[/\[.*]/])

      issue_messages =
        check_result.filter { |file_check_result| file_check_result['errorCount'].positive? }
                    .each_with_object([]) do |file_check_result, acc|
          acc << {
            file_path: file_check_result['filePath'],
            messages:
              file_check_result['messages'].map do |message|
                {
                  rule: message['ruleId'],
                  message: message['message'],
                  line_column: "#{message['line']}:#{message['column']}"
                }
              end
          }
        end

      {
        issue_messages: JSON.generate(issue_messages),
        issue_count:
          check_result.sum do |file_check_result|
            file_check_result['errorCount']
          end
      }
    end
  end
end
