require 'test_helper'

module Apidocs
  class ApidocsControllerTest < ActionController::TestCase
    def setup
      Apidocs.configuration_clear
    end

    test "should get index" do
      get :index, use_route: 'apidocs'
      assert_response :success
      assert_select 'article#main-content', /API\.rdoc/
      assert assigns :routes
      assert assigns :intro
      assert_select '#search-list li', 4
      assert_select '#search-list li ' do
        assert_select 'a[href]', /^\/products/
      end
    end

    test "show route" do
      get(:index, path: '/products/new', use_route: 'apidocs')
      assert_response :success
      assert_select 'article#main-content h3', 'GET /products/new'
      assert_select 'article#main-content p', 'New Product action'

    end

    test "show route with search" do
      get(:index, path: '/products/new', search: 'new', use_route: 'apidocs')
      assert_response :success
      assert_select 'article#main-content h3', 'GET /products/new'
      assert_select '#search-input[value=?]', 'new'
    end

    test "authenticate" do
      Apidocs.configure do |config|
        config.http_username = 'admin'
        config.http_password = '5ebe2294ecd0e0f08eab7690d2a6ee69'
      end
      get :index, use_route: 'apidocs'
      assert_response 401
      @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('admin', 'secret')
      get(:index, use_route: 'apidocs')
      assert_response :success
    end

    test "filter" do
      Apidocs.configure do |config|
        config.regex_filter = /new/
      end
      get :index, use_route: true
      assert_response :success
      assert_select '#search-list li', 1
    end
  end
end
