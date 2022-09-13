require "rails_helper"

RSpec.describe TokenPurchase do
  context "validations" do
    let!(:test_user) { Fabricate(:user, is_admin: true, id: 1) }
    let(:token) { Fabricate(:token_purchase, user_id: test_user.id) }

    #! check
    # it "checks presence validation is on the columns" do
    #   expect(token).to validate_presence_of :user_id
    #   expect(token).to validate_presence_of :amount
    #   expect(token).to validate_presence_of :total
    #   expect(token).to validate_presence_of :status
    # end

    it "has the correct relations on the model" do
      expect(token).to belong_to :user
    end

    it "has status only accept the correct values" do
      expect(token.status).to be_between(0, 2)
    end
  end
end
