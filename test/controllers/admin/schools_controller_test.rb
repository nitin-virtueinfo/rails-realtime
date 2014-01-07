require 'test_helper'

class Admin::SchoolsControllerTest < ActionController::TestCase
  setup do
    @admin_school = admin_schools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_schools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_school" do
    assert_difference('Admin::School.count') do
      post :create, admin_school: {  }
    end

    assert_redirected_to admin_school_path(assigns(:admin_school))
  end

  test "should show admin_school" do
    get :show, id: @admin_school
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_school
    assert_response :success
  end

  test "should update admin_school" do
    patch :update, id: @admin_school, admin_school: {  }
    assert_redirected_to admin_school_path(assigns(:admin_school))
  end

  test "should destroy admin_school" do
    assert_difference('Admin::School.count', -1) do
      delete :destroy, id: @admin_school
    end

    assert_redirected_to admin_schools_path
  end
end
