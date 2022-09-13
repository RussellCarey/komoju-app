require "rails_helper"

def authenticated_header(request, user)
  auth_headers = Devise::JWT::TestHelpers.auth_headers(response, user)
  request.headers["Authorization"] = auth_headers["Authorization"].split(" ")[1]
  request.headers.merge!(auth_headers)
end

RSpec.describe TokenPurchaseController, type: :controller do
  let!(:test_user) { Fabricate(:user, is_admin: true, id: 1) }
  let(:test_purchase) { Fabricate(:token_purchase, user_id: test_user.id) }

  before { sign_in test_user }

  context "GET #show_all" do
    it "Can get the users purchases and return them" do
      authenticated_header(request, test_user)
      get :show_all, as: :json
      expect(JSON.parse(response.body).length).to eq(1)
      assert_response :success
    end

    it "Cannot get all clients if not logged in" do
      sign_out test_user
      get :show_all, as: :json
      assert_response :unauthorized
    end
  end

  context "DELETE #destroy" do
    it "Can destroy a favourite" do
      authenticated_header(request, test_user)
      post :destroy, params: { id: test_purchase.id }, as: :json
      assert_response :ok
    end

    it "Cannot post client if not logged in" do
      sign_out test_user
      post :destroy, params: { id: test_purchase.id }, as: :json
      assert_response :unauthorized
    end
  end

  # context "Aggregate functions " do
  #   before do
  #     test_user_two = Fabricate(:user, is_admin: true, id: 2, email: "test2@test.com", username: "testing2")
  #     item_one = Fabricate(:game_purchase, user_id: test_user.id, created_at: "22/12/2022", status: 2)
  #     item_two = Fabricate(:game_purchase, user_id: test_user_two.id, created_at: "22/11/2022", status: 2)
  #     item_three = Fabricate(:game_purchase, user_id: test_user.id, created_at: "22/10/2022", status: 2)
  #     item_four = Fabricate(:game_purchase, user_id: test_user.id, created_at: "25/10/2022", status: 2, game_id: 1111, total: 1111)
  #   end

  #   it "Can get the total value of all completed sales" do
  #     authenticated_header(request, test_user)
  #     post :aggregate, params: { func: "total_sales_amount" }, as: :json
  #     total = JSON.parse(response.body)["data"][0]["total"]
  #     expect(total).to eq(4813.0)
  #     assert_response :ok
  #   end

  #   it "Can get the total NUMBER of all completed sales" do
  #     authenticated_header(request, test_user)
  #     post :aggregate, params: { func: "total_sales" }, as: :json
  #     total = JSON.parse(response.body)["data"][0]["total_sales"]
  #     expect(total).to eq(4)
  #     assert_response :ok
  #   end

  #   it "Can get the total NUMBER of all completed sales by item id, name etc" do
  #     authenticated_header(request, test_user)
  #     post :aggregate, params: { func: "total_sales_by", column: "game_id", value: 1111 }, as: :json
  #     total = JSON.parse(response.body)["data"][0]["total"]
  #     expect(total).to eq(1111.0)
  #     assert_response :ok
  #   end

  #   it "Can get the total value of all completed sales between a value" do
  #     authenticated_header(request, test_user)
  #     post :aggregate, params: { func: "total_sales_between", min: 1110, max: 1115 }, as: :json
  #     total = JSON.parse(response.body)["data"][0]["total"]
  #     expect(total).to eq(1111.0)
  #     assert_response :ok
  #   end

  #! Check
  # it "Can get the total value of all completed sales between dates" do
  #   authenticated_header(request, test_user)
  #   post :aggregate, params: { func: "total_sales_between_dates", min_date: "20/11/2022", max_date: "23/12/2022" }, as: :json
  #   total = JSON.parse(response.body)["data"][0]["total"]
  #   expect(total).to eq(1111.0)
  #   assert_response :ok
  # end
  # end
end
