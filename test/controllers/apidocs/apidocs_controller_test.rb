require 'test_helper'

module Apidocs
  class ApidocsControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end

  end
end
