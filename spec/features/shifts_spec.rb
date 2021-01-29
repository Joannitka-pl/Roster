require 'rails_helper'

feature 'Shift management' do

  before :each do
    visit shifts_path
  end

  scenario 'create shift and add new shift to shift list' do
    expect {
      click_on('Create shift')
      select('2021', from: 'shift[starting_at(1i)]')
      select('February', from: 'shift[starting_at(2i)]')
      select('2', from: 'shift[starting_at(3i)]')
      select('08', from: 'shift[starting_at(4i)]')
      select('00', from: 'shift[starting_at(5i)]')
      fill_in 'Duration', with: '4'
      select('3', from: 'Studio')
      click_on('Create Shift')
    }.to change(Shift, :count).by(1)
    expect(page).to  have_current_path(shifts_path)
    expect(page).to have_content('New shift was successfully created')
    expect(page).to have_content('02/02/21 08:00')
    expect(page).to have_content('4')
    expect(page).to have_content('3')
  end

  context 'for actions on exisiting shifts' do
    before :each do
      @shift = create(:shift)
      visit shifts_path
    end

    scenario 'edit shift' do
      within(".shift_#{@shift.id}") do
        click_on('Edit')
      end
        select('2', from: 'Studio')
        click_on('Update Shift')
        expect(page).to  have_current_path(shifts_path)
        expect(page).to have_content('Shift was successfully updated')
    end

    scenario 'delete shift' do
      expect {
        within(".shift_#{@shift.id}") do
          click_on('Delete')
        end
      }.to change(Shift, :count).by(-1)
      expect(page).to  have_current_path(shifts_path)
      expect(page).to have_content('Shift was successfully removed')
    end
  end
end