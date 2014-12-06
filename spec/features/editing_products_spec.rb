require 'rails_helper'

feature 'Product Management' do
  scenario 'User edits a product' do
    visit edit_product_path
    product = FactoryGirl.create(:product)

  end
end
