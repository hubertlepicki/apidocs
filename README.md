apidocs
=======

Generates and serves HTML documentation out of your routing and controllers for your Rails apps

Installation
=======

Add <code>mount Apidocs::Engine => "/apidocs"</code> to your applications <code>routes.rb</code>  

Configuration
=======

<code>
Apidocs.configure  do |config|
  config.regex_filter = /api/
  config.http_username = 'admin'  # optional http basic authorization 
  config.http_password = '5ebe2294ecd0e0f08eab7690d2a6ee69' # md5 hash for password
end
</code>
