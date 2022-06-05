# frozen_string_literal: true

require 'fileutils'

class RepositoryChecker
  def initialize(repository)
    @repository = repository
    @repository_directory_path = Rails.root.join('tmp', 'repositories', @repository.name)
  end

  def start_checking
    check_functions = {
      javascript: -> { check_js },
      ruby: -> { check_ruby }
    }

    create_directory
    clone_repository
    results = check_functions[@repository.language.to_sym].call
    delete_directory
    results
  end

  private

  def delete_directory
    FileUtils.rm_rf @repository_directory_path
  end

  def create_directory
    if Dir.exist? @repository_directory_path
      delete_directory
    end

    FileUtils.mkdir_p @repository_directory_path
  end

  def clone_repository
    clone_command =
      "git clone #{@repository.clone_url} #{@repository_directory_path}"
    Open3.popen3(clone_command) { |_stdin, stdout| stdout.read }
  end

  def check_ruby
    lint_command = "bundle exec rubocop #{@repository_directory_path} --format json -c .rubocop.yml"

    raw_check_result = Open3.popen3(lint_command) { |_stdin, stdout| stdout.read }
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

  def check_js
    lint_command =
      "yarn run eslint #{@repository_directory_path} --config .eslintrc.yml --format json --no-eslintrc"

    raw_check_result = Open3.popen3(lint_command) { |_stdin, stdout| stdout.read }
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
