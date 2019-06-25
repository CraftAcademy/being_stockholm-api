require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "DB columns" do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :caption }
    it { is_expected.to have_db_column :status }
    it { is_expected.to have_db_column :category }
    it { is_expected.to have_db_column :latitude }
    it { is_expected.to have_db_column :longitude }
    it { is_expected.to have_db_column :address }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:caption) }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }
    it { is_expected.to validate_length_of(:caption).is_at_most(140) }
    it { is_expected.to validate_presence_of(:address) }
  end

  describe "Association" do
    it { is_expected.to have_one(:image_attachment) }
  end

  describe "Factory" do
    it "should have valid factory" do
      expect(FactoryBot.create(:post)).to be_valid
    end
  end

  describe "Attachment" do
    it "is valid" do
      subject.image.attach(io: File.open('spec/fixtures/dummy_image.jpg'), filename: 'attachment.jpg', content_type: 'image/jpg')
      expect(subject.image).to be_attached
    end
  end

  describe "Association" do
    it { is_expected.to belong_to(:user) }
  end
end
