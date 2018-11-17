require 'rails_helper'

describe MovieInfoSendWorker, type: :worker do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }
  let(:file_path) { 'movies_export.csv' }

  it 'sends email' do
    delivery = double
    expect(delivery).to receive(:deliver_now).with(no_args)
    expect(MovieInfoMailer).to receive(:send_info).with(user, movie).and_return(delivery)

    subject.perform(user.id, movie.id)
  end

end
