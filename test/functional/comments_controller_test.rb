require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_redirected_to pranks_url
  end
  
  def test_get_without_login
    get :new
    assert_redirected_to new_sessions_path
    assert_equal "Please login to continue.", flash[:notice]
  end

  def test_should_get_new
    login_as :quentin
    get :new
    assert session[:user_id]
    assert_response :redirect
  end

  def test_should_create_comment
    login_as :quentin
    assert_difference('Comment.count') do
      post :create, :comment => { :user_id => 1, :prank_id => 1, :image_id => 1, :body => "Test comment." }
    end

    assert_redirected_to comment_path(assigns(:comment))
  end

  def test_should_show_comment
    get :show, :id => comments(:one).id
    assert_redirected_to pranks_url
  end

  def test_should_destroy_comment
    login_as :quentin
    assert_difference('Comment.count', -1) do
      delete :destroy, :id => comments(:one).id
    end

    assert_redirected_to comments_path
  end
end
