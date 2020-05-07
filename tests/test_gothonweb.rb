ENV['Rack_ENV'] = 'test'
require './bin/app.rb'
require 'test/unit'
require 'rack/test'


class MyAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end


  # def test_redirect
  #   get '/'
  #   follow_redirect!
  #
  #   assert_equal "http://example.org/login", last_request.url
  #   assert last_response.ok?
  # end
  #
  # def test_first_room
  #   get '/'
  #   get '/game'
  #   assert last_response.ok?
  #   assert last_response.body.include?("Central Corridor")
  # end
  #
  # def test_directions
  #   get '/'
  #   post '/game', params = {:action => 'tell a joke'}
  #   follow_redirect!
  #
  #   assert last_response.ok?
  #   assert 'Gothon Fight', last_response.body
  # end
  #
  # def test_invalid_answer
  #   get '/'
  #   post '/game', params = {:action => 'This is a test Terry!' }
  #   follow_redirect!
  #
  #   assert_equal "http://example.org/error", last_request.url
  #   assert last_response.ok?
  #   assert 'That was an invalid response please try again', last_response.body
  # end
  #
  #
  # def test_death
  #   get '/'
  #   post '/game', params = {:action => 'shoot'}
  #   follow_redirect!
  #
  #   assert last_response.ok?
  #   assert 'You Died', last_response.body
  # end

  def test_wrong_end
    # session = Rack::Test::Session.new(Rack::MockSession.new(app))
    get '/game' do
      session = {}
      Map::save_room(session, Map::ESCAPE_POD)
      Map::load_room(session)
    end
    puts last_response.body

    post '/game', params = {:action => 'lose game'}
    follow_redirect!

    assert last_response.ok?
    puts last_response.body
  end

end
