require 'rails_helper'

describe MoviesExportWorker, type: :worker do
  let(:user) { create(:user) }
  let(:file_path) { 'movies_export.csv' }

  it 'runs MovieExporter' do
    expect_any_instance_of(MovieExporter).to receive(:call).with(user, file_path)
    subject.perform(user.id, file_path)
  end
end
