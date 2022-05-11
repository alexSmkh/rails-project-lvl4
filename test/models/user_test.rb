# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup { @user = users(:one) }

  test 'valid user' do
    assert { @user.valid? }
  end

  test 'invalid user without nickname' do
    @user.nickname = nil
    assert_not @user.valid?
    assert_not_nil @user.errors[:nickname]
  end

  test 'invalid user without email' do
    @user.email = nil
    assert_not @user.valid?
    assert_not_nil @user.errors[:email]
  end

  test 'invalid user without uniq nickname' do
    already_used_nickname = @user.nickname
    new_user =
      User.new(nickname: already_used_nickname, email: Faker::Internet.email)
    assert_not new_user.valid?
    assert_not_nil new_user.errors[:nickname]
  end

  test 'invalid user without uniq email' do
    already_used_email = @user.email
    new_user =
      User.new(nickname: Faker::Internet.username, email: already_used_email)
    assert_not new_user.valid?
    assert_not_nil new_user.errors[:email]
  end

  test 'invalid user with too short nickname' do
    min_chars = User
                .validators_on(:nickname)
                .find { |v| v.instance_of? ActiveRecord::Validations::LengthValidator }
                .options[:minimum]

    @user.nickname = Faker::Lorem.characters(number: min_chars - 1)
    assert_not @user.valid?
    assert_not_nil @user.errors[:nickname]
  end

  test 'invalid user with too long nickname' do
    min_chars = User
                .validators_on(:nickname)
                .find { |v| v.instance_of? ActiveRecord::Validations::LengthValidator }
                .options[:maximum]

    @user.nickname = Faker::Lorem.characters(number: min_chars + 1)
    assert_not @user.valid?
    assert_not_nil @user.errors[:nickname]
  end
end
