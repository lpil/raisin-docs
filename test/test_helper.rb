ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'
require 'minitest/rails/capybara'

FactoryGirl.find_definitions

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
  # order.
  fixtures :all
end

class Capybara::Rails::TestCase
  # Metaprogram a handy method for various user types
  #   i.e. new_signed_in_user
  # Creates a new user (or other), signs them in, and returns the someone
  %i(user admin uploader reporter).each do |type|
    define_method("new_signed_in_#{type}") do
      someone = FactoryGirl.create type
      sign_in someone
      someone
    end
  end
end
