require "application_system_test_case"

class DogsTest < ApplicationSystemTestCase
  # Happy Path Tests
  test "visiting the index and submitting form with 'hound'" do
    visit root_path

    assert_selector "h1", text: "Dog Breed Pics"

    fill_in "Breed", with: "hound"
    click_on "Submit"

    assert_text "Here's your pic for hound"
    assert_selector "img"
  end

  test "visiting the index and submitting form with 'Corgi'" do
    visit root_path

    fill_in "Breed", with: "Corgi"
    click_on "Submit"

    assert_text "Here's your pic for Corgi"
    assert_selector "img"
  end

  # Unhappy Path Tests
  test "visiting the index and submitting form with 'Unicorn'" do
    visit root_path

    fill_in "Breed", with: "Unicorn"
    click_on "Submit"

    assert_text "Unicorn not found. Perhaps try a different breed, like 'Corgi'"
    assert_no_selector "img"
  end

  test "visiting the index and submitting form with empty breed" do
    visit root_path

    click_on "Submit"

    assert_text "Breed name cannot be empty. Please enter a valid breed."
    assert_no_selector "img"
  end

  # Additional Tests
  test "visiting the index and submitting form with case insensitive breed 'HOUND'" do
    visit root_path

    fill_in "Breed", with: "HOUND"
    click_on "Submit"

    assert_text "Here's your pic for HOUND"
    assert_selector "img"
  end

  test "visiting the index and submitting form with leading and trailing whitespace '  hound  '" do
    visit root_path

    fill_in "Breed", with: "  hound  "
    click_on "Submit"

    assert_text "Here's your pic for hound"
    assert_selector "img"
  end

end
