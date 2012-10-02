require 'test_helper'

class PartySetsControllerTest < ActionController::TestCase
  setup do
    @party_set = party_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:party_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create party_set" do
    assert_difference('PartySet.count') do
      post :create, party_set: { name: @party_set.name, notes: @party_set.notes, prefix: @party_set.prefix }
    end

    assert_redirected_to party_set_path(assigns(:party_set))
  end

  test "should show party_set" do
    get :show, id: @party_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @party_set
    assert_response :success
  end

  test "should update party_set" do
    put :update, id: @party_set, party_set: { name: @party_set.name, notes: @party_set.notes, prefix: @party_set.prefix }
    assert_redirected_to party_set_path(assigns(:party_set))
  end

  test "should destroy party_set" do
    assert_difference('PartySet.count', -1) do
      delete :destroy, id: @party_set
    end

    assert_redirected_to party_sets_path
  end
end
