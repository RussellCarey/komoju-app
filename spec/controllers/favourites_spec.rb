require "rails_helper"

def authenticated_header(request, user)
  auth_headers = Devise::JWT::TestHelpers.auth_headers(response, user)
  request.headers["Authorization"] = auth_headers["Authorization"].split(" ")[1]
  request.headers.merge!(auth_headers)
end

RSpec.describe FavouritesController, type: :controller do
  let(:test_user) { Fabricate(:user, is_admin: true) }

  before { sign_in test_user }

  # context "GET #all" do
  #   it "Can get the users owned clients and return them" do
  #     authenticated_header(request, test_user)
  #     get :all, as: :json
  #     expect(JSON.parse(response.body).length).to eq(1)
  #     assert_response :success
  #   end

  #   it "Cannot get all clients if not logged in" do
  #     sign_out test_user

  #     get :all, as: :json
  #     assert_response :unauthorized
  #   end
  # end

  #  context 'GET #show' do
  #     it 'Can find and return a single resource ONLY if it is owned by the user' do
  #         authenticated_header(request, test_user)
  #         new_client = Fabricate(:client, user_id: test_user.id)
  #         get :show, params: { id: new_client.id }, as: :json
  #         assert_response :success
  #     end

  #     it 'Cannot get a client if not logged in' do
  #         sign_out test_user
  #         get :show, params: { id: 2 }, as: :json
  #         assert_response :unauthorized
  #     end
  # end

  context "POST #create" do
    it "Can create a new client" do
      puts test_user.inspect
      authenticated_header(request, test_user)
      post :create, params: { game_id: 0000, image: "testimage.image.com", name: "Test game", price: 1000, user_id: test_user.id }, as: :json
      assert_response :ok
    end

    # it "Cannot post client if not logged in" do
    #   sign_out test_user

    #   post :create,
    #        params: {
    #          email: "testingclientt@test.com",
    #          first_name: "Mrrr",
    #          last_name: "Client",
    #          address_number: 36,
    #          address_street: "sdfsdf",
    #          address_city: "23423432",
    #          address_county: "243234",
    #          address_postcode: "PO33RFV",
    #          user_id: test_user.id
    #        },
    #        as: :json
    #   assert_response :unauthorized
    # end
  end

  # context 'GET #index ' do
  #     it 'Can check the user is an admin and can return all clients' do
  #         sign_in test_user_admin
  #         authenticated_header(request, test_user_admin)
  #         get :index, as: :json
  #         expect(JSON.parse(response.body).length).to eq(2);
  #         assert_response :success
  #     end

  #     it 'Will fail as the user is not an admin' do
  #         authenticated_header(request, test_user)
  #         get :index, as: :json
  #         assert_response :unauthorized
  #     end
  # end
end
