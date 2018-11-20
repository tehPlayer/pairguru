require "rails_helper"

describe Movie do
  it { is_expected.to allow_value("Deadpool").for(:title) }
  it { is_expected.not_to allow_value("Deadpool ()").for(:title) }
end
