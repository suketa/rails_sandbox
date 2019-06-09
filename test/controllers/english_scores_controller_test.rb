require 'test_helper'

class EnglishScoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @english_score = english_scores(:one)
  end

  test "should get index" do
    get english_scores_url
    assert_response :success
  end

  test "should get new" do
    get new_english_score_url
    assert_response :success
  end

  test "should create english_score" do
    assert_difference('EnglishScore.count') do
      post english_scores_url, params: { english_score: { listening: @english_score.listening, name: @english_score.name, passed: @english_score.passed, reading: @english_score.reading, speaking: @english_score.speaking, writing: @english_score.writing } }
    end

    assert_redirected_to english_score_url(EnglishScore.last)
  end

  test "should show english_score" do
    get english_score_url(@english_score)
    assert_response :success
  end

  test "should get edit" do
    get edit_english_score_url(@english_score)
    assert_response :success
  end

  test "should update english_score" do
    patch english_score_url(@english_score), params: { english_score: { listening: @english_score.listening, name: @english_score.name, passed: @english_score.passed, reading: @english_score.reading, speaking: @english_score.speaking, writing: @english_score.writing } }
    assert_redirected_to english_score_url(@english_score)
  end

  test "should destroy english_score" do
    assert_difference('EnglishScore.count', -1) do
      delete english_score_url(@english_score)
    end

    assert_redirected_to english_scores_url
  end
end
