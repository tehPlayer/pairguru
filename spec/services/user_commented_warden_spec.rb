require 'rails_helper'

describe UserCommentedWarden do
  let(:user) { create(:user, :confirmed) }
  let(:movie) { create(:movie) }

  subject { described_class.new(user, movie) }

  it 'returns false if user didnt comment on the movie' do
    expect(subject.check).to eq(false)
  end

  it 'returns true if user did comment on the movie' do
    create(:comment, movie: movie, user: user)
    expect(subject.check).to eq(true)
  end
end