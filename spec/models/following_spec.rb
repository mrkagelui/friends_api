require 'rails_helper'

RSpec.describe Following, type: :model do
  it { is_expected.to belong_to(:user_where_it_is_source) }
  it { is_expected.to belong_to(:user_where_it_is_audience) }
  it { is_expected.to validate_presence_of(:user_where_it_is_source) }
  it { is_expected.to validate_presence_of(:user_where_it_is_audience) }
end
