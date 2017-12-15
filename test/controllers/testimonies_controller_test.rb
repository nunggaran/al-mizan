require 'test_helper'

class TestimoniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @testimony = testimonies(:one)
  end

  test "should get index" do
    get testimonies_url
    assert_response :success
  end

  test "should get new" do
    get new_testimony_url
    assert_response :success
  end

  test "should create testimony" do
    assert_difference('Testimony.count') do
      post testimonies_url, params: { testimony: { content: @testimony.content, user_id: @testimony.user_id } }
    end

    assert_redirected_to testimony_url(Testimony.last)
  end

  test "should show testimony" do
    get testimony_url(@testimony)
    assert_response :success
  end

  test "should get edit" do
    get edit_testimony_url(@testimony)
    assert_response :success
  end

  test "should update testimony" do
    patch testimony_url(@testimony), params: { testimony: { content: @testimony.content, user_id: @testimony.user_id } }
    assert_redirected_to testimony_url(@testimony)
  end

  test "should destroy testimony" do
    assert_difference('Testimony.count', -1) do
      delete testimony_url(@testimony)
    end

    assert_redirected_to testimonies_url
  end
end
