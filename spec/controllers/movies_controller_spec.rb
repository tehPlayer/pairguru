require "rails_helper"
require "sidekiq/testing"

describe MoviesController, type: :controller do
  describe "#export" do
    let(:user) { create(:user, :confirmed) }

    before do
      sign_in user
    end

    it "schedules export job" do
      expect{
        get :export
      }.to change(Sidekiq::Queues['default'], :size).by(1)
    end
  end

  describe "#send_info" do
    let(:movie) { create(:movie) }
    let(:user) { create(:user, :confirmed) }

    before do
      sign_in user
    end

    it "schedules send info job" do
      expect{
        get :send_info, params: {id: movie.id}
      }.to change(Sidekiq::Queues['default'], :size).by(1)
    end
  end
end