require 'test_helper'

class ScrapeSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scrape_session = scrape_sessions(:one)
  end

  test "should get index" do
    get scrape_sessions_url
    assert_response :success
  end

  test "should get new" do
    get new_scrape_session_url
    assert_response :success
  end

  test "should create scrape_session" do
    assert_difference('ScrapeSession.count') do
      post scrape_sessions_url, params: { scrape_session: { scrape_date: @scrape_session.scrape_date, scrape_time: @scrape_session.scrape_time } }
    end

    assert_redirected_to scrape_session_url(ScrapeSession.last)
  end

  test "should show scrape_session" do
    get scrape_session_url(@scrape_session)
    assert_response :success
  end

  test "should get edit" do
    get edit_scrape_session_url(@scrape_session)
    assert_response :success
  end

  test "should update scrape_session" do
    patch scrape_session_url(@scrape_session), params: { scrape_session: { scrape_date: @scrape_session.scrape_date, scrape_time: @scrape_session.scrape_time } }
    assert_redirected_to scrape_session_url(@scrape_session)
  end

  test "should destroy scrape_session" do
    assert_difference('ScrapeSession.count', -1) do
      delete scrape_session_url(@scrape_session)
    end

    assert_redirected_to scrape_sessions_url
  end
end
