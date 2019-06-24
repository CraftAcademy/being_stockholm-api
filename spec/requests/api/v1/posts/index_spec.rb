RSpec.describe Api::V1::PostsController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:another_user) { FactoryBot.create(:user, email: 'felix@craft.com') }
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe "GET /api/v1/posts" do

    before do
      5.times { FactoryBot.create(:post, user_id: user.id) }
    end

    it "returns a collection of posts" do
      get "/api/v1/posts", headers: headers
      expect(json_response.count).to eq 5
    end

    it "returns 200 response" do
      get "/api/v1/posts", headers: headers
      expect(response.status).to eq 200
    end
    
    it "has correct keys in the response" do
      get "/api/v1/posts", headers: headers

      posts= Post.all

      posts.each do |post|
        expect(json_response[posts.index(post)]).to include('id')
        expect(json_response[posts.index(post)]).to include('status')
        expect(json_response[posts.index(post)]).to include('latitude')
        expect(json_response[posts.index(post)]).to include('longitude')
      end
    end

    describe 'for a specific user' do
      before do
        5.times { FactoryBot.create(:post, user_id: user.id) }
        4.times { FactoryBot.create(:post, user_id: another_user.id) } 
        get '/api/v1/posts', params: {user_id: another_user.id} 
      end

      it "lists only users posts" do
        user_posts = Post.where(user_id: another_user.id)
        user_posts.each do |user_post|
          expect(json_response[user_posts.index(user_post)]['user']['id']).to eq another_user.id
        end
        expect(json_response.count).to eq 4
      end
    end
  end
end