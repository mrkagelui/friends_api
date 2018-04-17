require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to allow_value('alice.bob@cat.com').for(:email) }
  it { is_expected.not_to allow_value('alice@bob').for(:email) }

  it { is_expected.to have_many(:friendships_as_user1).dependent(:destroy) }
  it { is_expected.to have_many(:friendships_as_user2).dependent(:destroy) }
  it { is_expected.to have_many(:followings_as_source).dependent(:destroy) }
  it { is_expected.to have_many(:followings_as_audience).dependent(:destroy) }
  it { is_expected.to have_many(:blockades_as_blocker).dependent(:destroy) }
  it { is_expected.to have_many(:blockades_as_blockee).dependent(:destroy) }
end
