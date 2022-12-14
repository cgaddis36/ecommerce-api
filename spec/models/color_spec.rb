require 'rails_helper'

RSpec.describe Color, type: :model do
  it { should have_many(:item_size_colors) }
  it { should have_many(:items).through(:item_size_colors)}
  it { should have_many(:sizes).through(:item_size_colors)}
end
