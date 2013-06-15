class Book < ApiClient::Base
  self.association = { :author => 'Author' }

  attr_accessor :name, :author_id, :publish_date
end