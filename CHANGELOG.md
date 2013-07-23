# CHANGELOG

## v2.2.0

* Add support global basic authentication.
* Add support for gem Zertico

## v2.1.0

* Add support for classes with compost names.

## v2.0.3

* Fix put and patch requisitions.

## v2.0.2

* Changed to_hash method behavior to return a root node.
* Fix instance requisitions by send a root node.

## v2.0.1

* Removed trailing slash from post requisitions.

## v2.0.0

* Fix typhoeus requisitions by changing params method to body.
* Add Support to configure header globally.
* Improved readability by changing methods names.

## v2.0.0.rc2

* Fix initialization with root nodes for nested objects.
* Add Support for object initialization with strings as keys.

## v2.0.0.rc1

* Add Support for global url.
* Add Support for instance requests.
* Changed behavior of request methods to only accepts the resource id if needed.

## v1.10.0

* Add Support for api responses with collections.

## v1.9.1

* Fix for Net::Http on NotFound Exception.

## v1.9.0

* Added Requested Url to NotFound Exception message.

## v1.8.2

* Fixed Query String Bug (It was been sent empty).

## v1.8.1

* Fixed a Bug when response was an Array.

## v1.8.0

* Methods to return attributes of the class added.

## v1.7.0

* Support for Associations added.

## v1.6.0

* Initial Support for Typhoeus added.
* Fixed bug with get request and headers.
* Support for ruby 1.8.7, 1.9.2, jruby and ree added.

## v1.5.1 to v1.5.4

* Fixed Bug with errors from external API and self.

## v1.5.0

* Handler of arrays as response.
* Method to redefine response object added.

## v1.4.1

* ActiveModel compatibility for errors added. make all error keys symbolic.

## v1.4.0

* functionality to validate on client side using ApiClient::Base added.

## v1.3.0

* functionality to read args with a root node added.

## v1.2.0

* methods put, patch and delete added.
* changed post method to send as json by default, but left option to override it.
* header params added to methods.

## v1.1.1

* fix for post when uri has a non default port (80).

## v1.1.0

* changed post method to always send as json.

## v1.0.0

* handler for response code 400 removed.
* Refactoring of usage.

## v0.6.0

* handler for response code 400 added.

## v0.5.0

* handler for connection refused added.

## v0.4.1

* rename gem name to fix require issues.

## v0.4.0

* handlers for response code 500, 502 and 503 added.

## v0.3.0

* handler for response code 401 added.

## v0.2.0

* post method added

## v0.1.0

* generic exception added.

## v0.0.1

* get method added.
* handler for response code 404 added.
