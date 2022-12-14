require 'rails_helper'

RSpec.describe Size, type: :model do
  it { should have_many(:item_size_colors) }
  it { should have_many(:items).through(:item_size_colors)}
  it { should have_many(:colors).through(:item_size_colors)}
end
