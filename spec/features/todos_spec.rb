require 'rails_helper'

RSpec.describe 'Todos', type: :feature, js: true do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it 'creates a new todo' do
    visit root_path

    # Fill in the form and submit it
    fill_in 'todo[title]', with: 'Test Todo'
    click_button 'Add'

    # Wait for the todo to appear on the page
    expect(page).to have_content('Test Todo')
  end

  it 'updates an existing todo' do
    todo = Todo.create!(title: 'Old Todo')

    visit root_path

    # Find the existing todo, fill in the new title, and submit the form
    within "li#todo_#{todo.id}" do
      fill_in 'todo[title]', with: 'Updated Todo'
      click_button 'Save'
    end

    # Wait for the todo to update
    expect(page).to have_content('Updated Todo')
    expect(page).not_to have_content('Old Todo')
  end

  it 'marks a todo as completed' do
    todo = Todo.create!(title: 'Incomplete Todo', completed: false)

    visit root_path

    # Check the box to mark it as completed
    within "li#todo_#{todo.id}" do
      check 'todo[completed]'
    end

    # Reload the todo and confirm it's marked as completed
    expect(todo.reload.completed).to be true
  end

  it 'deletes a todo' do
    todo = Todo.create!(title: 'Delete Me')

    visit root_path

    # Click the delete button
    within "li#todo_#{todo.id}" do
      click_button 'Delete'
    end

    # Wait for the todo to disappear from the page
    expect(page).not_to have_content('Delete Me')
  end
end
