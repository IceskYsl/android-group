This is the source code of [Ruby China Group](http://ruby-china.org)

## Install

  * You need *Ruby 1.9.2+*, *Rubygems* and *Rails 3.2+* first.
  * Install and start *Redis*, *MongoDB*, *memcached*, *Python*, *Pygments*

  ```
  cp config/config.yml.default config/config.yml
  cp config/mongoid.yml.default config/mongoid.yml
  cp config/redis.yml.default config/redis.yml
  bundle install
  rake assets:precompile
<<<<<<< HEAD
<<<<<<< HEAD
  #use thin
=======
  rake db:seed
>>>>>>> ruby-china/master
  thin start -O -C config/thin.yml
  #or use unicorn
  ./script/unicorn.start.sh
=======
  rake db:seed
  thin start -O -C config/thin.yml
>>>>>>> ruby-china/master
  ./script/resque start
  bundle exec rake sunspot:solr:start
  easy_install pygments # 或者 pip install pygments
  rake db:migrate
  ```
  or you can just this issue 
  ```
  rake test:init
  ```
  to prepare all the config files and start essential services.

## Deploy

    $ cap deploy
    $ cap production remote_rake:invoke task=db:setup

## OAuth

* be sure to use: http://ruby-china.dev/
* callback url: http://ruby-china.dev/account/auth/github/callback

# Apply Google JSAPI

* http://code.google.com/intl/zh-CN/apis/loader/signup.html

## 麵包屑

### in controller

    drop_breadcrumb("A Level")
    drop_breadcrumb("B Level")

## Menu

    render_list :class => "menu" do |li|
      li << link_to("Home", "/")
    end

## Bootstrap CSS version

1.4.0

## Bootstrap Form

<https://github.com/rafaelfranca/simple_form-bootstrap/blob/master/config/initializers/simple_form.rb>

## Memcached

Dalli requires memcached 1.4.x +

## Helpers

    render_topic_title(topic)

## Common Partial

* common/user\_nav : user\_navigation_bar

## Facebook Share

facekbook_enable: false by default

## Styling Guide

* Don't put plain html in helper
* NEVER LOGIC in View
* 重複用到的方法請隨手用 Helper 包
* 永遠使用括號 () 包覆複雜 Helper

## Contributors

* [Contributors](https://github.com/huacnlee/ruby-china/contributors)

## Thanks

* [Twitter Bootstrap](https://twitter.github.com/bootstrap)

Forked from [Homeland Project](https://github.com/huacnlee/homeland)

## License

Copyright (c) 2011-2012 Ruby China

Released under the MIT license:

* [www.opensource.org/licenses/MIT](http://www.opensource.org/licenses/MIT)
