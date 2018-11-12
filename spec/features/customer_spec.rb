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

  scenario 'Click on Customer show link' do
    customer = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['Y', 'N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/images/avatar.png"
    )

    visit(customers_path)

    find(:xpath, '/html/body/table/tbody/tr[1]/td[3]/a').click

    expect(page).to have_content('Showing User')
  end

  scenario 'Check Customers index' do
    customer1 = Customer.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['Y', 'N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/images/avatar.png"
    )

    customer2 = Customer.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['Y', 'N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/images/avatar.png"
    )

    visit(customers_path)
    expect(page).to have_content(customer1.name).and have_content(customer2.name)
  end
  
  scenario 'Update a Customer' do
    customer = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['Y', 'N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/images/avatar.png"
    )

    visit(edit_customer_path(customer.id))

    new_name = Faker::Name.name

    fill_in('Name', with: new_name)
    
    click_on('Create Customer')
    
    expect(page).to have_content('Customer Successfully Updated')
    expect(page).to have_content(new_name)
  end

  scenario 'Click on Customer edit link' do
    customer = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['Y', 'N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/images/avatar.png"
    )

    visit(customers_path)

    find(:xpath, '/html/body/table/tbody/tr[1]/td[4]/a').click

    expect(page).to have_content('Edit Customer')
  end

  scenario 'Destroy a Customer', js: true do
    customer = Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      smoker: ['Y', 'N'].sample,
      avatar: "#{Rails.root}/spec/fixtures/images/avatar.png"
    )

    visit(customers_path)

    find(:xpath, '/html/body/table/tbody/tr[1]/td[5]/a').click

    page.driver.browser.switch_to.alert.accept

    expect(page).to have_content('Customer Deleted Successfully')
  end
  
end
