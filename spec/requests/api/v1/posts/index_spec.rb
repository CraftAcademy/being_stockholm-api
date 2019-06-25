RSpec.describe Api::V1::PostsController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:another_user) { FactoryBot.create(:user, email: 'felix@craft.com') }
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe "GET /api/v1/posts" do

    before do
      5.times do      
        post_user = FactoryBot.create(:post, user_id: user.id)
        post_user.image.attach(io: File.open('spec/fixtures/dummy_image.jpg'), filename: 'attachment.jpg', content_type: 'image/jpg')
      end

      4.times do      
        post_another_user = FactoryBot.create(:post, user_id: another_user.id)
        post_another_user.image.attach(io: File.open('spec/fixtures/dummy_image.jpg'), filename: 'attachment.jpg', content_type: 'image/jpg')
      end
    end

    it "returns a collection of posts" do
      get "/api/v1/posts", headers: headers
      expect(json_response.count).to eq 9
    end

    it "returns 200 response" do
      get "/api/v1/posts", headers: headers
      expect(response.status).to eq 200
    end
    
    it "has correct keys in the response" do
      get "/api/v1/posts", headers: headers

      posts = Post.all

      posts.each do |post|
        expect(json_response[posts.index(post)]).to include('id')
        expect(json_response[posts.index(post)]).to include('status')
        expect(json_response[posts.index(post)]).to include('latitude')
        expect(json_response[posts.index(post)]).to include('longitude')
        expect(json_response[posts.index(post)]).to include('address')
      end
    end

    describe 'for a specific user' do
      
      it "lists only users posts" do
        get '/api/v1/posts', params: {user_id: another_user.id} 
        user_posts = Post.where(user_id: another_user.id)
        user_posts.each do |user_post|
          expect(json_response[user_posts.index(user_post)]['user']['id']).to eq another_user.id
        end
        expect(json_response.count).to eq 4
      end
    end
  end
end