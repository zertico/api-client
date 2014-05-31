# ApiClient::Dispatcher provides methods to make requests using typhoeus
class ApiClient::Dispatcher::Parallel
  # Initialize a new object and save the request in a instance variable.
  #
  # @param [Typhoeus::Request] requisition the requisition object.
  def initialize(requisition)
    @requisition = requisition
  end

  # When the requisition finish, this method update the given object with the response.
  #
  # @param [ApiClient::Base, ApiClient::Collection] variable the object to update with the response.
  def on_complete_update(variable)
    @requisition.on_complete do |response|
      attributes = ApiClient::Parser.response(response, response.effective_url)
      if variable.instance_of?(ApiClient::Collection)
        variable.update(attributes)
      else
        variable.attributes = attributes
      end
    end
    ApiClient.config.hydra.queue @requisition
  end

  %w(get delete).each do |method|
    class_eval <<-EVAL
        def #{method}(url, header = {})
          new(::Typhoeus::Request.new(url, :method => '#{method}', :headers => ApiClient.config.header.merge(header)))
        end
    EVAL
  end

  %w(post put patch).each do |method|
    class_eval <<-EVAL
        def #{method}(url, args, header = {})
          new(::Typhoeus::Request.new(url, :method => '#{method}', :body => args, :headers => ApiClient.config.header.merge(header)))
        end
    EVAL
  end
end