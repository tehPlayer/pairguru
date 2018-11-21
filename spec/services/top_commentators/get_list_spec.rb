require "rails_helper"

describe TopCommentators::GetList do
  let(:users) { create_list(:user, described_class::USERS_MAX + 1) }
  let!(:user1) { users.first }
  let!(:user2) { users.second }
  let!(:user3) { users.third }

  subject { described_class.perform! }

  before do
    create_list(:comment, 2, user: user1)
    create_list(:comment, 3, user: user2)
    create_list(:comment, 1, user: user3)
    users.each {|u| create(:comment, user: u)}
  end

  it 'pulls commentators in correct order' do
    expect(subject.results.first(3)).to eq([user2, user1, user3])
  end

  it 'pulls only limited number of creators' do
    expect(subject.results.size).to eq(described_class::USERS_MAX)
  end
end