require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { should belong_to(:item_size_color) }
  it { should belong_to(:order) }
end
