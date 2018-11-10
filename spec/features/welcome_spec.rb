require 'rails_helper'

feature 'Welcomes', type: :feature do
  scenario 'Show the welcome message' do
    visit('/')
    expect(page).to have_content('Welcome')
  end
end
