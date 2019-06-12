require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "DB columns" do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :caption }
    it { is_expected.to have_db_column :status }
    it { is_expected.to have_db_column :category }
    it { is_expected.to have_db_column :latitude }
    it { is_expected.to have_db_column :longitude }
  end

  describe "Validations" do
    it { is_expected.to have_validate_presence_of(:caption) }
    it { is_expected.to have_validate_presence_of(:status) }
    it { is_expected.to have_validate_presence_of(:category) }
    it { is_expected.to have_validate_presence_of(:latitude) }
    it { is_expected.to have_validate_presence_of(:longitude) }
  end

  describe "Factory" do
    it "should have valid factory" do
      expect(FactoryBot.create(:post)).to be_valid
    end
  end

end
