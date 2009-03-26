require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def test_valid_comment
    comment1 = comments(:one)
    comment2 = comments(:two)
    assert comment1.valid?
    assert comment2.valid?
  end
  
  def test_invalid_with_empty_attributes
    comment = Comment.new
    assert !comment.valid?
    assert comment.errors.invalid?(:body)
    assert comment.errors.invalid?(:user_id)
  end
end
