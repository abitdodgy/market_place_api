require 'test_helper'

class ApiConstraintsTest < ActiveSupport::TestCase
  setup do
    @api_constraints_v1 = ApiConstraints.new(version: 1)
    @api_constraints_v2 = ApiConstraints.new(version: 2, default: true)
  end

  test "matches? returns true when the version matches the 'Accept' header" do
    request = OpenStruct.new(
      host: 'api.marketplace.dev',
      headers: { "Accept" => "application/vnd.marketplace.v1" }
    )
    assert @api_constraints_v1.matches?(request)
  end

  test "matches? returns the default version when 'default' option is specified" do
    request = OpenStruct.new(host: 'api.marketplace.dev')
    assert @api_constraints_v2.matches?(request)
  end
end
