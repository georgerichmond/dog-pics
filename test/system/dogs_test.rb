require "application_system_test_case"
require 'webmock/minitest'

class DogsTest < ApplicationSystemTestCase

  setup do
    WebMock.allow_net_connect!
    stub_request(:get, "https://dog.ceo/api/breeds/list/all")
      .to_return(
        status: 200,
        body: {
          "status": "success",
          "message": {
            "corgi": [],
            "hound": [],
            "poodle": [],
            "terrier": [],
            "wolfhound": ["irish"]
          }
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

  end
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

  test "entering a breed with a sub breed separated by a space" do
    visit root_path

    fill_in "Breed", with: "golden retriever"
    click_on "Submit"

    assert_text "Here's your pic for golden retriever"
    assert_selector "img"
  end


  test "autocomplete suggestions appear when typing breed name" do
    visit root_path

    fill_in "Breed", with: "ter"
    assert_selector "#breed-suggestions li", text: "terrier"

    fill_in "Breed", with: "poo"
    assert_selector "#breed-suggestions li", text: "poodle"
  end

  test "autocomplete suggestions disappear when input is cleared" do
    visit root_path

    fill_in "Breed", with: "ter"
    assert_selector "#breed-suggestions li", text: "terrier"

    fill_in "Breed", with: ""
    assert_no_selector "#breed-suggestions li"
  end

  test "selecting a suggestion from the autocomplete list populates the input field" do
    visit root_path

    fill_in "Breed", with: "ter"
    assert_selector "#breed-suggestions li", text: "terrier"

    find("#breed-suggestions li", text: "terrier").click
    assert_field "Breed", with: "terrier"
  end

  test "submitting form with a breed selected from autocomplete suggestions" do
    visit root_path

    fill_in "Breed", with: "poo"
    assert_selector "#breed-suggestions li", text: "poodle"

    find("#breed-suggestions li", text: "poodle").click
    click_on "Submit"

    assert_text "Here's your pic for poodle"
    assert_selector "img"
  end

  test "entering and then clearing the dog name autocomplete" do
    visit root_path

    fill_in "Breed", with: "poo"
    assert_selector "#breed-suggestions li", text: "poodle"

    fill_in "Breed", with: ""
    assert_no_selector "#breed-suggestions li"
  end

end
