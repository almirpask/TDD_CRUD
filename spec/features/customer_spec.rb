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

  scenario 'Create a new Customer' do
    visit(new_customer_path)
    customer_name = Faker::Name.name
    fill_in('customer_name', with:customer_name)
    fill_in('customer_email', with: Faker::Internet.email)
    fill_in('customer_phone', with: Faker::PhoneNumber.phone_number)
    attach_file('customer_avatar', "#{Rails.root}/spec/fixtures/images/avatar.png")
    choose(option: ['Y','N'].sample)

    click_on('Create Customer')

    expect(page).to have_content('Customer Created Successfully')
    expect(Customer.last.name).to eq(customer_name)
  end

  scenario 'Create a new Customer with out fill the form' do
    visit(new_customer_path)
    click_on('Create Customer')

    expect(page).to have_content("can't be blank")
  end

  scenario 'Show a Customer' do
    customer = Customer.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['Y', 'N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/images/avatar.png"
    )

    visit(customer_path(customer.id))
    expect(page).to have_content(customer.name)
  end
end
