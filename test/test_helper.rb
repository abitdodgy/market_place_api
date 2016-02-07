ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/autorun'

Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  include Support::Request::JSONHelpers
  include Support::Request::HeadersHelpers

  fixtures :all

  def as_parsed_json(object, options = {})
  	JSON.parse object.to_json(options), symbolize_names: true
  end
end
