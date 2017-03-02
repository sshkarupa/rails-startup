# frozen_string_literal: true
# Check spec/support dir is auto-required in spec/rails_helper.rb.
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
