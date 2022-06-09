# frozen_string_literal: true

module ApplicationHelper
  include AuthConcern

  def build_flash_messages(content)
    if content.instance_of?(Array)
      return content.map { |msg| tag.p(class: 'mb-0') { msg } }.join
    end

    tag.p(class: 'mb-0') { content }
  end
end
