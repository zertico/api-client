# ApiClient

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'api_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install api_client

## Usage

Add this to your ApplicationController:

    rescue_from ApiClient::Exceptions::NotFound, :with => :not_found

    def not_found
       #Specify your own behavior here
    end

Then, on your action, just put into it:

    @user = ApiClient.get("http://api.example.com/user/3")

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
