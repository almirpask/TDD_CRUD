require 'rails_helper'

feature 'Welcome', type: :feature do
  scenario 'Show the welcome message' do
    visit(root_path)
    expect(page).to have_content('Welcome')
  end

  scenario 'Show the Customers link' do
    visit(root_path)
    expect(find('ul li')).to have_link('Customers')
  end
end
