require 'rails_helper'

feature 'Welcomes', type: :feature do
  scenario 'Show the welcome message' do
    visit(root_path)
    expect(page).to have_content('Welcome')
  end
end
