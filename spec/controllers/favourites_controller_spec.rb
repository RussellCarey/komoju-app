require "rails_helper"

def authenticated_header(request, user)
  auth_headers = Devise::JWT::TestHelpers.auth_headers(response, user)
  request.headers["Authorization"] = auth_headers["Authorization"].split(" ")[1]
  request.headers.merge!(auth_headers)
end

RSpec.describe FavouritesController, type: :controller do
  let!(:test_user) { Fabricate(:user, is_admin: true, id: 1) }
  let(:test_favourite) { Fabricate(:favourite, user_id: test_user.id) }

  before { sign_in test_user }

  context "GET #show_all" do
    it "Can get the users favourites and return them" do
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

  context "POST #create" do
    it "Can create a new client" do
      authenticated_header(request, test_user)
      post :create, params: { game_id: 0000, image: "testimage.image.com", name: "Test game", price: 1000, user_id: test_user.id }, as: :json
      assert_response :ok
    end

    it "Cannot post client if not logged in" do
      sign_out test_user
      post :create, params: { game_id: 0000, image: "testimage.image.com", name: "Test game", price: 1000, user_id: test_user.id }, as: :json
      assert_response :unauthorized
    end
  end

  context "DELETE #destroy" do
    it "Can destroy a favourite" do
      authenticated_header(request, test_user)
      post :destroy, params: { id: test_favourite.id }, as: :json
      assert_response :ok
    end

    it "Cannot post client if not logged in" do
      sign_out test_user
      post :destroy, params: { id: test_favourite.id }, as: :json
      assert_response :unauthorized
    end
  end

  context "Aggregate functions " do
    before do
      test_user_two = Fabricate(:user, is_admin: true, id: 2, email: "test2@test.com", username: "testing2")
      item_one = Fabricate(:favourite, user_id: test_user.id, created_at: "12/12/2022")
      item_two = Fabricate(:favourite, user_id: test_user_two.id, created_at: "11/11/2022")
      item_three = Fabricate(:favourite, user_id: test_user.id, created_at: "10/10/2022")
    end

    it "will fail if user is not an admin" do
      sign_out test_user
      post :aggregate, params: { func: "in_favourites" }, as: :json
      assert_response :unauthorized
    end

    it "Can get the value of all users current favourites" do
      authenticated_header(request, test_user)
      post :aggregate, params: { func: "in_favourites" }, as: :json
      value = JSON.parse(response.body)["data"][0]["total_value"]
      expect(value).to eq(3702.0)
      assert_response :ok
    end
  end
end
