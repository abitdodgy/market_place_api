require 'test_helper'

class API::V1::OrdersControllerTest < ActionController::TestCase
  setup do
    include_default_request_headers
  end

  test "GET #index when not signed in" do
    get :index
    assert_response :unauthorized
  end

  test "GET #index when signed in" do
    user = create(:user)
    api_authorization_header token: user.auth_token

    orders = 3.times.map {
      create(:order, user: user).tap do |order|
        order.products << create(:product)
      end
    }

    expected = as_parsed_json Order.where(id: orders).includes(:user, products: :owner), json_options

    get :index
    assert_equal expected, json_response_body
    assert_response :success
  end

  test "GET #show when not signed in" do
    get :show, id: 1
    assert_response :unauthorized
  end

  test "GET #show when wrong user" do
    user = create(:user)
    api_authorization_header token: user.auth_token
    get :show, id: create(:order)
    assert_response :forbidden
  end

  test "GET #show when owner" do
    order = create(:order)
    user = order.user
    api_authorization_header token: user.auth_token

    get :show, id: order
    expected = as_parsed_json Order.includes(:user, products: :owner).find(order.id), json_options

    assert_equal expected, json_response_body
    assert_response :success
  end

  test "POST #create when not signed in" do
    post :create, order: { product_ids: [1,2] }
    assert_response :unauthorized
  end

  test "POST #create when signed in" do
    user = create(:user)
    api_authorization_header token: user.auth_token
    products = 2.times.map { create(:product) }

    post :create, order: { product_ids: products.map(&:id) }
    expected = as_parsed_json Order.includes(:user, products: :owner).last, json_options

    assert_equal expected, json_response_body
    assert_response :created
  end

private

  def json_options
    {
      only: [
        :id, :total_in_cents, :status, :created_at, :updated_at
      ],
      include: {
        user: {
          only: [
            :id, :name, :email, :created_at
          ]
        },
        products: {
          only: [
            :id, :title, :price_in_cents, :created_at, :updated_at
          ],
          include: {
            owner: {
              only: [
                :id, :name, :email, :created_at
              ]
            }
          }
        }
      }
    }
  end
end
