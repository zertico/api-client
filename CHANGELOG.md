# CHANGELOG

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
