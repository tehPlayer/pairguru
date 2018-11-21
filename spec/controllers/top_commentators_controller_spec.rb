require 'rails_helper'

RSpec.describe TopCommentatorsController, type: :controller do

  describe "GET #index" do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:user3) { create(:user) }
    let!(:non_commenting_user) { create(:user) }

    before do
      create_list(:comment, 2, user: user1)
      create_list(:comment, 3, user: user2)
      create_list(:comment, 1, user: user3)
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'shows ordered number of commentators' do
      get :index
      expect(assigns(:top_commentators)).to eq([user2, user1, user3])
    end
  end

end
