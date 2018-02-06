require "application_system_test_case"

class OfficesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit "/"
    assert_selector "h1", text: "Find your delivery office"
    assert_selector ".office", count: Office.count
  end

  test "adding an office" do
    visit "/"

    click_on "Add office"

    fill_in "Name", with: "Test creating office"
    fill_in "Postcode", with: "le17rh"
    click_on "Submit your office"

    assert_text "Test creating office"
  end

  test "searching for the office" do
    visit "/"

    fill_in "Postcode", with: "EC4R1EB"
    fill_in "Radius [mi]", with: "3"
    click_on "Search"

    assert_selector ".office", text: "2.5"
  end

  test "no results" do
    visit "/"

    fill_in "Postcode", with: "AB24 5NS"
    fill_in "Radius [mi]", with: "50"
    click_on "Search"

    assert_selector "h2", text: "Sorry no results"
  end
end
