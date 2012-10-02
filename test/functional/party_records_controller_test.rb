require 'test_helper'

class PartyRecordsControllerTest < ActionController::TestCase
  setup do
    @party_record = party_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:party_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create party_record" do
    assert_difference('PartyRecord.count') do
      post :create, party_record: { forename: @party_record.forename, testident: @party_record.testident, notes: @party_record.notes, partySet_id: @party_record.partySet_id, surname: @party_record.surname }
    end

    assert_redirected_to party_record_path(assigns(:party_record))
  end

  test "should show party_record" do
    get :show, id: @party_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @party_record
    assert_response :success
  end

  test "should update party_record" do
    put :update, id: @party_record, party_record: { forename: @party_record.forename, testident: @party_record.testident, notes: @party_record.notes, partySet_id: @party_record.partySet_id, surname: @party_record.surname }
    assert_redirected_to party_record_path(assigns(:party_record))
  end

  test "should destroy party_record" do
    assert_difference('PartyRecord.count', -1) do
      delete :destroy, id: @party_record
    end

    assert_redirected_to party_records_path
  end
end
