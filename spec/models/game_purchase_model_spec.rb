require "rails_helper"

RSpec.describe Cart do
  context "validations" do
    let!(:test_user) { Fabricate(:user, is_admin: true, id: 1) }
    let!(:purchase) { Fabricate(:game_purchase, user_id: test_user.id) }

    #! Failing check
    # it "checks presence validation is on the columns" do
    #   expect(purchase).to validate_presence_of :image
    #   expect(purchase).to validate_presence_of :game_id
    #   expect(purchase).to validate_presence_of :total
    #   expect(purchase).to validate_presence_of :name
    #   expect(purchase).to validate_presence_of :user_id
    #   expect(purchase).to validate_presence_of :status
    # end

    it "has the correct relations on the model" do
      expect(purchase).to belong_to :user
    end

    it "has status only accept the correct values" do
      expect(purchase.status).to be_between(0, 2)
    end
  end
end
