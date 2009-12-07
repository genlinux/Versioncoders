require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  test "valid_user" do
    user=User.new(:username=>'fred',:email=>'fred@example.com',:password=>'abc123',:password_confirmation=>'abc123',:profile=>'A regular guy')
    assert user.save
  end
  test "invalid_duplicate_user" do
    user=User.new(:username=>'joe',:email=>'fred@example.com',:password=>'abc123',:password_confirmation=>'abc123',:profile=>'A regular guy')
    assert !user.save
  end
  
  test "incorrect_password" do 
    user=User.new(:username=>'admin',:email=>'admin@example.com',:password=>'abc123',:password_confirmation=>'abc123',:profile=>'A regular guy')
    assert user.save
  end
end
