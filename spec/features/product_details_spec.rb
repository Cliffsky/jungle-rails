require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
  end

  scenario "They visit a product page" do
    # ACT
    visit root_path
    page.first('.product a').click


    # VERIFY
    expect(page).to have_css 'section.products-show'

    # DEBUG
    save_screenshot
  end
end
