require "application_system_test_case"

class DogsTest < ApplicationSystemTestCase
  # Happy Path Tests
  test "visiting the index" do
    visit root_path

    assert_selector "h1", text: "Dog Breed Pics"

  end
end
