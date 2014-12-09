require 'rails_helper'

feature "Product Management" do
  scenario "User creates a new product" do
    visit new_product_path

    fill_in 'Name', with: 'Apple'
    fill_in 'Description', with: 'A juicy apple'
    fill_in 'Image URL', with: 'apple.png'
    fill_in 'Price', with: '0.99'

    click_button 'Create Product'

    expect(page).to have_text('Product was successfully created')
  end

  scenario 'User edits a product' do
    product = FactoryGirl.create(:product)
    visit edit_product_path(product)

    fill_in 'Name', with: 'Apple'

    click_button 'Update Product'

    expect(page).to have_text('Product was successfully updated')
    expect(page).to have_text('Apple')
  end

  scenario 'User views a product' do
    product = FactoryGirl.create(:product)
    visit '/'
    click_link 'Show'

    expect(page).to have_text(product.name)

  end

  scenario 'User views a list of products' do
    product1 = FactoryGirl.create(:product)
    product2 = FactoryGirl.create(:product)

    visit '/'
    expect(page).to have_text(product1.name)
    expect(page).to have_text(product2.name)

    # save_and_open_page
  end

  scenario 'User deletes a product' do
    product = FactoryGirl.create(:product)

    visit '/'
    click_link 'Destroy'

    expect(page).to have_content('Product was successfully deleted')

    within('table') do
      expect(page).to_not have_content(product.name)
      expect(page).to_not have_content(product.description)
      expect(page).to_not have_content(product.img_url)
      expect(page).to_not have_content(product.price)
    end
    # save_and_open_page
  end
end
