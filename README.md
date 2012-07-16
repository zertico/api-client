# ApiClient [![Build Status](https://secure.travis-ci.org/plribeiro3000/api-client.png)](http://travis-ci.org/plribeiro3000/api-client)

Client to make Api calls easily. The master only supports ruby-1.9.3.
For older versions, check branch retro-compatibility.

## Installation

Add this line to your application's Gemfile:

    gem 'api-client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install api-client

## Basic Usage

Add this to your ApplicationController:

    rescue_from ApiClient::Exceptions::NotFound, :with => :not_found

    def not_found
       #Specify your own behavior here
    end

You can define a more generic rescue that will work for any error:

    rescue_from ApiClient::Exceptions::Generic, :with => :generic_error

On Your model, extend ApiClient::Base

    class User < ApiClient::Base

Then, on your action, just put into it:

    @user = User.get("http://api.example.com/user/3")

## Advanced Usage

ApiClient can read api responses with root nodes based on the name of the virtual class.
In Some cases, that is not the required behavior. To Redefine it, use remote_object method:

    class Admin < ApiClient::Base
       self.remote_object = "user"
    end

## TODO
   * Add Support to Typhoeus and Faraday
   * Proper Treatment for validation errors
   * Add more Response Handlers

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
