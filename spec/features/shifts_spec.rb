require 'rails_helper'

feature 'Shift management' do

  before :each do
    @shift = create(:shift)
    visit shifts_path
  end

  scenario 'create new shift' do
    expect {
      click_on('Create shift')
      select('2020', from: 'shift[date(1i)]')
      select('September', from: 'shift[date(2i)]')
      select('30', from: 'shift[date(3i)]')
      select('1 6', from: 'Hour')
      select('1', from: 'Studio')
      click_on('Create Shift')
    }.to change(Shift, :count).by(1)
    expect(page).to  have_current_path(shifts_path)
    expect(page).to have_content('New shift was successfully created')
  end

  scenario 'edit shift' do
    find(:xpath, "//a[@href='/shifts/#{@shift.id}/edit']").click
    select('2', from: 'Studio')
    click_on('Update Shift')
    expect(page).to  have_current_path(shifts_path)
    expect(page).to have_content('Shift was successfully updated')
  end

  scenario 'delete shift' do
    expect {
      find(:xpath, "//a[@href='/shifts/#{@shift.id}' and @data-method='delete']").click
    }.to change(Shift, :count).by(-1)
    expect(page).to  have_current_path(shifts_path)
    expect(page).to have_content('Shift was successfully removed')
  end

end

 