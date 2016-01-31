require 'test_helper'

class API::V1::ProductsControllerTest < ActionController::TestCase
  setup do
    include_default_request_headers
  end

  test "GET #show" do
    product = create(:product)
    get :show, id: product

    expected = as_parsed_json product, json_options

    assert_equal expected, json_response_body
    assert_response :success
  end

  test "GET #index" do
    3.times { |n| create(:product, published: n.even?) }
    get :index

    expected = as_parsed_json Product.includes(:owner).where(published: true), json_options

    assert_equal expected, json_response_body
    assert_response :success
  end

  test "POST #create when not authenticated" do
    post :create, product: attributes_for(:product)
    assert_response :unauthorized
  end

  test "POST #create with valid attributes" do
    user = create(:user)
    api_authorization_header token: user.auth_token

    post :create, product: attributes_for(:product)
    expected = as_parsed_json Product.last, json_options

    assert_equal expected, json_response_body
    assert_response :created
  end

  test "POST #create with invalid attributes" do
    attributes = attributes_for(:product).except!(:title)

    user = create(:user)
    api_authorization_header token: user.auth_token

    assert_no_difference 'Product.count' do
      post :create, product: { price_in_cents: 1 }
    end

    expected = {
      errors: Product.new(attributes, &:valid?).errors.messages
    }

    assert_equal expected, json_response_body
    assert_response :unprocessable_entity
  end

private

  def json_options
    {
      only: [
        :id, :title, :price_in_cents, :created_at, :updated_at
      ],
      include: [
        owner: {
          only: [
            :id, :name, :email, :created_at
          ]
        }
      ]
    }
  end
end
