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

  scenario 'User views an existing product' do
    product = FactoryGirl.create(:product)
    visit product_path(product)

    expect(page).to have_text(product.name)
    expect(page).to have_text(product.description)
    expect(page).to have_text(product.price)
    expect(page).to have_image(product.image_url.downcase)
  end

  scenario 'User views a list of products' do
    product1 = FactoryGirl.create(:product)
    product2 = FactoryGirl.create(:product)

    visit products_path

    expect(page).to have_text(product1.name)
    expect(page).to have_text(product1.description)
    expect(page).to have_text(product1.price)
    expect(page).to have_image(product1.image_url.downcase)

    expect(page).to have_text(product2.name)
    expect(page).to have_text(product2.description)
    expect(page).to have_text(product2.price)
    expect(page).to have_image(product2.image_url.downcase)
    # save_and_open_page
  end

  scenario 'User deletes a product' do
    product = FactoryGirl.create(:product)
    product2 = FactoryGirl.create(:product)

    visit products_path
    within "#product_#{product.id}" do
      click_link 'Destroy'
    end

    expect(page).to have_content('Product was successfully destroyed.')

      expect(page).to_not have_content(product.name)
      expect(page).to_not have_content(product.description)
      expect(page).to_not have_image(product.image_url.downcase)
      expect(page).to_not have_content(product.price)

    # save_and_open_page
  end
end
