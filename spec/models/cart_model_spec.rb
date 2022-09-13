require "rails_helper"

RSpec.describe Cart do
  context "validations" do
    let!(:test_user) { Fabricate(:user, is_admin: true, id: 1) }
    let(:cart) { Fabricate(:cart, user_id: test_user.id) }

    it "checks presence validation is on the columns" do
      expect(cart).to validate_presence_of :image
      expect(cart).to validate_presence_of :game_id
      expect(cart).to validate_presence_of :price
      expect(cart).to validate_presence_of :name
    end
  end
end
