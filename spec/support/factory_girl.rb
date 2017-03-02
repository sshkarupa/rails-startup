# frozen_string_literal: true
# Check spec/support dir is auto-required in spec/rails_helper.rb.
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    begin
      DatabaseCleaner.start
      # Test factories in spec/factories are working.
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
end
