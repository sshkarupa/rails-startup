# frozen_string_literal: true

require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'puma'

Capybara.server_host = '0.0.0.0'
Capybara.server_port = 3001 + ENV['TEST_ENV_NUMBER'].to_i
Capybara.default_max_wait_time = 2
Capybara.save_path = './tmp/capybara_output'
Capybara.always_include_port = true # for correct app_host

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    timeout: 90, js_errors: true,
    phantomjs_logger: Logger.new(STDOUT),
    window_size: [1020, 740]
  )
end

Capybara.javascript_driver = :poltergeist

Capybara.server = :puma
