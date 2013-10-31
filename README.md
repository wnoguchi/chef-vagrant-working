# Chef Solo and Vagrant Work-repo

Chef SoloとVagrantの勉強用のリポジトリです。

## システム要件

* Mac OS X
* ruby 1.9.3
* rbenv
* bundler

このリポジトリをクローンしたらまず以下のことをやらなければなりません。

```
bundle install --path vendor/bundle
```

## よく使うコマンド

### Vagrant

```
vagrant init
vagrant up
vagrant halt
vagrant destroy
```

### chef-solo

```
bundle exec knife solo init chef-repo
cd chef-repo/
bundle exec knife cookbook create nagios -o site-cookbooks
（レシピの記述: `site-cookbooks/nagios/recipes/default.rb` 等）
bundle exec knife solo prepare target1
(ノードファイル編集)
bundle exec knife solo cook target1
```

* サードパーティ製のクックブックをchefレポジトリにインポートする

```
bundle exec knife cookbook site vendor yum
```
