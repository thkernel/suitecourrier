require "application_system_test_case"

class TicketTypesTest < ApplicationSystemTestCase
  setup do
    @ticket_type = ticket_types(:one)
  end

  test "visiting the index" do
    visit ticket_types_url
    assert_selector "h1", text: "Ticket Types"
  end

  test "creating a Ticket type" do
    visit ticket_types_url
    click_on "New Ticket Type"

    fill_in "Description", with: @ticket_type.description
    fill_in "Name", with: @ticket_type.name
    fill_in "Status", with: @ticket_type.status
    fill_in "Uid", with: @ticket_type.uid
    fill_in "User", with: @ticket_type.user_id
    click_on "Create Ticket type"

    assert_text "Ticket type was successfully created"
    click_on "Back"
  end

  test "updating a Ticket type" do
    visit ticket_types_url
    click_on "Edit", match: :first

    fill_in "Description", with: @ticket_type.description
    fill_in "Name", with: @ticket_type.name
    fill_in "Status", with: @ticket_type.status
    fill_in "Uid", with: @ticket_type.uid
    fill_in "User", with: @ticket_type.user_id
    click_on "Update Ticket type"

    assert_text "Ticket type was successfully updated"
    click_on "Back"
  end

  test "destroying a Ticket type" do
    visit ticket_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ticket type was successfully destroyed"
  end
end
