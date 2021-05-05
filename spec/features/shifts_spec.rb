require 'rails_helper'

feature 'Shift management' do
  let(:shift) { create(:shift) }
 
  scenario 'create shift and add new shift to shift list' do
    expect {
      visit shifts_path 
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
      within('div#flash-message') do
        expect(page).to have_selector(class:'success', text: 'New shift was successfully created', count: 1)
      end
      within('tr.shits-table__shift') do
        expect(page).to have_selector(class:'shifts-table__studio', text: '3')
        expect(page).to have_selector(class:'shifts-table__duration', text: '4')
        expect(page).to have_selector(class:'shifts-table__starting-at', text: '02/02/21 08:00')
      end 
  end

  context 'for actions on exisiting shifts' do
    before :each do
      @shift = create(:shift)
      visit shifts_path 
    end

    scenario 'edit shift' do
      within("#shift_#{@shift.id}") do
        click_on('Edit')
      end
        select('2', from: 'Studio')
        click_on('Update Shift')
        expect(page).to  have_current_path(shifts_path)
        within('div#flash-message') do
          expect(page).to have_selector(class:'success', text: 'Shift was successfully updated', count: 1)
        end
    end

    scenario 'delete shift' do
      expect {
        within("#shift_#{@shift.id}") do
          click_on('Delete')
        end
      }.to change(Shift, :count).by(-1)
      expect(page).to  have_current_path(shifts_path)
      within('div#flash-message') do
        expect(page).to have_selector(class:'success', text: 'Shift was successfully removed', count: 1)
      end
    end
  end
end