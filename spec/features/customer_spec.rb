require 'rails_helper'

feature "Customer", type: :feature do
  scenario 'Find Customer link' do
    visit(root_path)
    expect(page).to have_link('Customers')
  end

  scenario 'Click on Customers link' do
    visit(root_path)
    click_on('Customers')
    expect(page).to have_content('Customers List')
    expect(page).to have_link('New Customer')
  end

  scenario 'Click on New Customer link' do
    visit(customers_path)
    click_on('New Customer')
    expect(page).to have_content('New Customer')
  end
end
