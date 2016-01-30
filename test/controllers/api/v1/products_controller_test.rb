require 'test_helper'

class API::V1::ProductsControllerTest < ActionController::TestCase
  test "GET #show" do
    product = create(:product)
    get :show, id: product

    assert_equal product.to_json, json_response_body
  end
end
