require "application_system_test_case"

class ActivityLogsTest < ApplicationSystemTestCase
  setup do
    @activity_log = activity_logs(:one)
  end

  test "visiting the index" do
    visit activity_logs_url
    assert_selector "h1", text: "Activity Logs"
  end

  test "creating a Activity log" do
    visit activity_logs_url
    click_on "New Activity Log"

    fill_in "Action", with: @activity_log.action
    fill_in "Browser", with: @activity_log.browser
    fill_in "Controller", with: @activity_log.controller
    fill_in "Ip address", with: @activity_log.ip_address
    fill_in "Note", with: @activity_log.note
    fill_in "Params", with: @activity_log.params
    fill_in "Uid", with: @activity_log.uid
    fill_in "User", with: @activity_log.user_id
    click_on "Create Activity log"

    assert_text "Activity log was successfully created"
    click_on "Back"
  end

  test "updating a Activity log" do
    visit activity_logs_url
    click_on "Edit", match: :first

    fill_in "Action", with: @activity_log.action
    fill_in "Browser", with: @activity_log.browser
    fill_in "Controller", with: @activity_log.controller
    fill_in "Ip address", with: @activity_log.ip_address
    fill_in "Note", with: @activity_log.note
    fill_in "Params", with: @activity_log.params
    fill_in "Uid", with: @activity_log.uid
    fill_in "User", with: @activity_log.user_id
    click_on "Update Activity log"

    assert_text "Activity log was successfully updated"
    click_on "Back"
  end

  test "destroying a Activity log" do
    visit activity_logs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Activity log was successfully destroyed"
  end
end
