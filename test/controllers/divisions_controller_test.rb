require 'test_helper'

class DivisionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @division = divisions(:one)
  end

  test "should get index" do
    get divisions_url
    assert_response :success
  end

  test "should get new" do
    get new_division_url
    assert_response :success
  end

  test "should create division" do
    assert_difference('Division.count') do
      post divisions_url, params: { division: { description: @division.description, direction_id: @division.direction_id, name: @division.name, status: @division.status } }
    end

    assert_redirected_to division_url(Division.last)
  end

  test "should show division" do
    get division_url(@division)
    assert_response :success
  end

  test "should get edit" do
    get edit_division_url(@division)
    assert_response :success
  end

  test "should update division" do
    patch division_url(@division), params: { division: { description: @division.description, direction_id: @division.direction_id, name: @division.name, status: @division.status } }
    assert_redirected_to division_url(@division)
  end

  test "should destroy division" do
    assert_difference('Division.count', -1) do
      delete division_url(@division)
    end

    assert_redirected_to divisions_url
  end
end
