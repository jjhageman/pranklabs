require 'test_helper'

class PranksControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:pranks)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_prank
    assert_difference('Prank.count') do
      post :create, :prank => { }
    end

    assert_redirected_to prank_path(assigns(:prank))
  end

  def test_should_show_prank
    get :show, :id => pranks(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => pranks(:one).id
    assert_response :success
  end

  def test_should_update_prank
    put :update, :id => pranks(:one).id, :prank => { }
    assert_redirected_to prank_path(assigns(:prank))
  end

  def test_should_destroy_prank
    assert_difference('Prank.count', -1) do
      delete :destroy, :id => pranks(:one).id
    end

    assert_redirected_to pranks_path
  end
end
