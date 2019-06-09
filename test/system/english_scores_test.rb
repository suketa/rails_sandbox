require "application_system_test_case"

class EnglishScoresTest < ApplicationSystemTestCase
  setup do
    @english_score = english_scores(:one)
  end

  test "visiting the index" do
    visit english_scores_url
    assert_selector "h1", text: "English Scores"
  end

  test "creating a English score" do
    visit english_scores_url
    click_on "New English Score"

    fill_in "Listening", with: @english_score.listening
    fill_in "Name", with: @english_score.name
    check "Passed" if @english_score.passed
    fill_in "Reading", with: @english_score.reading
    fill_in "Speaking", with: @english_score.speaking
    fill_in "Writing", with: @english_score.writing
    click_on "Create English score"

    assert_text "English score was successfully created"
    click_on "Back"
  end

  test "updating a English score" do
    visit english_scores_url
    click_on "Edit", match: :first

    fill_in "Listening", with: @english_score.listening
    fill_in "Name", with: @english_score.name
    check "Passed" if @english_score.passed
    fill_in "Reading", with: @english_score.reading
    fill_in "Speaking", with: @english_score.speaking
    fill_in "Writing", with: @english_score.writing
    click_on "Update English score"

    assert_text "English score was successfully updated"
    click_on "Back"
  end

  test "destroying a English score" do
    visit english_scores_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "English score was successfully destroyed"
  end
end
