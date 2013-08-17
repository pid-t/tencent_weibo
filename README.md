# TencentWeibo

这是[腾讯微博](http://t.qq.com/)的一个ruby sdk，灵感来自于新浪微博的一个ruby gem[link](https://github.com/simsicon/weibo_2)
目前只实现了关系链接口，微博接口，微博接口，名单接口, 并且没有推送到ruby gem上。

## 安装

目前尚未提交到ruby gem上，因此不能直接gem install安装

1. Clone 源代码到vendor/gems目录下
2. 修改Gemfile
`tencent_weibo， :path => "vendor/gems/tencent_weibo"`
3. bundle install安装 

## 使用

api参考腾讯微博开放平台[link](http://wiki.open.t.qq.com/index.php/API%E6%96%87%E6%A1%A3)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
