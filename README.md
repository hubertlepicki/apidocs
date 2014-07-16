apidocs
=======

Generates and serves HTML documentation out of your routing and controllers for your Rails apps.

For better safety, in configuration file there is a MD5 hash of password used instead of actual password. To generate it for your configuration use Digest::MD5.hexdigest('YOUR-PASSWORD-HERE'). It can be done in irb after requiring 'digest/md5'.

Installation
=======

Add ```mount Apidocs::Engine => "/apidocs"``` to your applications ```routes.rb```  

Configuration
=======

    Apidocs.configure  do |config|
      config.regex_filter = /\A\/api/ # filter routes
      config.http_username = 'admin'  # optional http basic authorization 
      config.http_password = '5ebe2294ecd0e0f08eab7690d2a6ee69' # md5 hash for password
    end
