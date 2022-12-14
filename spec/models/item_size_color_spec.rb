require 'rails_helper'

RSpec.describe ItemSizeColor, type: :model do
  it { should have_many(:order_items) }
  it { should have_many(:orders).through(:order_items) }
  it { should have_many(:cart_items) }
  it { should have_many(:carts).through(:cart_items) }
  it { should belong_to(:size) }
  it { should belong_to(:item)}
  it { should belong_to(:color)}
end
