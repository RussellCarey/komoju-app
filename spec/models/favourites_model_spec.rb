require "rails_helper"

RSpec.describe Favourite do
  context "validations" do
    let!(:test_user) { Fabricate(:user, is_admin: true, id: 1) }
    let(:favourite) { Fabricate(:favourite, user_id: test_user.id) }

    it "checks presence validation is on the columns" do
      expect(favourite).to validate_presence_of :image
      expect(favourite).to validate_presence_of :game_id
      expect(favourite).to validate_presence_of :price
      expect(favourite).to validate_presence_of :name
    end
  end
end
