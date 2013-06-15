require 'api-client'

# Make a get requisition to http://api.example.com/users and initialize an user object for each user returned
users = User.collection

# Get the first user
user = users.first

# Set the attribute type to 'admin'
user.type = 'admin'

# Make a put requisition to http://api.example.com/users/:id to update the user attributes
user.put # or user.patch

# Iterate over the books of the given user
user.books.each do |book|
  # Make a get requisition to http://api.example.com/books/:id to update the given book attributes
  book.get
  # Make a delete requisition to http://api.example.com/books/:id destroy the object if the publish_date is equal '1990'
  book.delete if book.publish_date == '1990'
end

# Make a get requisition to http://api.example.com/authors and initialize an author object for each author returned
authors = Author.collection

# Iterate over the authors
authors.each do |author|
  # Set @author to the current author if it is the one
  @author = author if author.name == 'Author Name'
end

# Initialize a new object
book = Book.new

# Set the name on the book object
book.name = 'book'
# Set the author_id of the book object with the chosen author id
book.author_id = @author.id
# Set the publish date of the book object
book.publish_date = '2002'
# Make a post requisition to http://api.example.com/books to create the book with the object attributes
book.post