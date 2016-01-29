ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  include Support::Request::JSONHelpers
  include Support::Request::HeadersHelpers

  fixtures :all
end
