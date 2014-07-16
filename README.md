APIDOCS
=======

Generates on fly and serves RDoc documentation out of your controllers actions.

Implemented as rails engine 

Installation
=======
Apidocs works with Rails 3.2 onwards. You can add it to your Gemfile with:

```gem 'apidocs'```

Run the bundle command to install it.

Add ```mount Apidocs::Engine => "/apidocs"``` to your applications ```routes.rb```  

Configuration
=======

For better safety, in configuration file there is a MD5 hash of password used instead of actual password. 
To generate it for your configuration use Digest::MD5.hexdigest('YOUR-PASSWORD-HERE'). 
It can be done in irb after requiring 'digest/md5'.

    Apidocs.configure  do |config|
      config.regex_filter = /\A\/api/ # filter routes
      config.http_username = 'admin'  # optional http basic authorization 
      config.http_password = '5ebe2294ecd0e0f08eab7690d2a6ee69' # md5 hash for password
    end
