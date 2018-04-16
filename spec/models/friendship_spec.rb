require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it { is_expected.to validate_presence_of(:user_where_it_is_user1) }
  it { is_expected.to validate_presence_of(:user_where_it_is_user1) }
  it { is_expected.to belong_to(:user_where_it_is_user1) }
  it { is_expected.to belong_to(:user_where_it_is_user1) }
end
