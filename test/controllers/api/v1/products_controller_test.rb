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

    assert_difference 'Product.count', 1 do
      post :create, product: attributes_for(:product)
    end
    expected = as_parsed_json Product.last, json_options

    assert_equal expected, json_response_body
    assert_response :created
  end

  test "POST #create with invalid attributes" do
    attributes = attributes_for(:product).except!(:title)

    user = create(:user)
    api_authorization_header token: user.auth_token

    assert_no_difference 'Product.count' do
      post :create, product: attributes
    end

    expected = {
      errors: Product.new(attributes, &:valid?).errors.messages
    }

    assert_equal expected, json_response_body
    assert_response :unprocessable_entity
  end

  test "PATCH #update when not authenticated" do
    patch :update, id: 1
    assert_response :unauthorized
  end

  test "PATCH #update when not owner" do
    user = create(:user)
    api_authorization_header token: user.auth_token

    product = create(:product)
    patch :update, id: product

    assert_response :forbidden
  end

  test "PATCH #update when owner with valid attributes" do
    user = create(:user)
    api_authorization_header token: user.auth_token

    product = create(:product, owner: user)
    patch :update, id: product, product: { title: "New Title" }

    json_response_body do |body|
      expected = as_parsed_json(product.reload, json_options)
      assert_equal expected, body
    end

    assert_equal "New Title", product.title
    assert_response :success
  end

  test "PATCH #update when owner with invalid attributes" do
    user = create(:user)
    api_authorization_header token: user.auth_token

    product = create(:product, owner: user, title: "Fabulous Stuff")
    patch :update, id: product, product: { title: nil }

    expected = {
      errors: {
        title: [
          "can't be blank"
        ]
      }
    }

    assert_equal expected, json_response_body
    assert_equal "Fabulous Stuff", product.reload.title
    assert_response :unprocessable_entity
  end

  test "DELETE #destroy when not authenticated" do
    assert_no_difference 'Product.count' do
      delete :destroy, id: 1
    end

    assert_response :unauthorized
  end

  test "DELETE #destroy when not owner" do
    user = create(:user)
    api_authorization_header token: user.auth_token
    product = create(:product)

    assert_no_difference 'Product.count' do
      delete :destroy, id: product
    end

    assert_response :forbidden
  end

  test "DELETE #destroy when owner" do
    user = create(:user)
    api_authorization_header token: user.auth_token
    product = create(:product, owner: user)

    assert_difference 'Product.count', -1 do
      delete :destroy, id: product
    end

    assert_response :no_content
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
