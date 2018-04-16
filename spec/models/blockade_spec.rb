require 'rails_helper'

RSpec.describe Blockade, type: :model do
  it { is_expected.to validate_presence_of(:user_where_it_is_blocker) }
  it { is_expected.to validate_presence_of(:user_where_it_is_blockee) }
  it { is_expected.to belong_to(:user_where_it_is_blocker) }
  it { is_expected.to belong_to(:user_where_it_is_blockee) }
end
