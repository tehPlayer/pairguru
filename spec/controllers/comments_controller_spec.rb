require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe '#create' do
    let(:user) { create(:user, :confirmed) }
    let(:movie) { create(:movie) }
    let(:params) { { movie_id: movie.id, comment: movie_params } }

    subject { post :create, params: params }

    before do
      sign_in user
    end

    describe 'invalid comment' do
      context 'empty comment' do
        let(:movie_params) { {content: ''} }

        it 'doesnt create an empty comment' do
          expect{subject}.to_not change(Comment, :count)
        end
      end

      context 'user already commented' do
        let(:movie_params) { {content: 'asdf'} }

        it 'doesnt create a comment, if user already commented' do
          create(:comment, user: user, movie: movie)
          expect{subject}.to_not change(Comment, :count)
        end
      end
    end

    describe 'valid comment' do
      let(:movie_params) { {content: 'asdf'} }

      it 'creates a comment' do
        expect{subject}.to change(Comment, :count).by(1)
      end
    end
  end
end
