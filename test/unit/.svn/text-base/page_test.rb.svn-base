require 'test_helper'

class PageTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  test "test_invalid_if_any_field_empty" do
  page=Page.new
  assert !page.valid?
  assert page.errors.invalid?(:title)
  assert page.errors.invalid?(:body)
  end
  test "test_valid_fields" do
  page=pages(:valid_page)
  assert page.valid?
  end
  test "test_invalid_short_title" do
  page=pages(:invalid_page_short_title)
  assert !page.valid?
  end
  test "test_valid_auto_permalink" do
  page=pages(:valid_with_auto_permalink)
  assert page.valid?
  end
end
