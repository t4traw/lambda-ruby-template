# Lambdaをrubyランタイムで動かすサンプル

標準以外のgemを使ったrubyスクリプトをlambdaで動かすサンプル。

## コード書くときの注意点

gemなどを全部パッケージ(zip)しないといけないので、

```
$ bundle install --path vendor/bundle
```

でローカルにインストールするようにしておく。

bundler自体ないとダメじゃね？と思ったが大丈夫だった。ローカルで開発する時に、bundle経由で実行しないといけないので、

```
$ bundle exec ruby app.rb
```

といった具合に実行する。

あと実行は関数単位なので、関数にまとめておき、`(event:, context:)`を引数に設定しておく。

```ruby
def foobar(event:, context:)
  p event
  p context
end
```

## デプロイ

デプロイする前にlambdaで関数を作成しておく。関数名とファイル名などは一致していなくても良い。

イベントハンドラの設定は`filename.functuon_name`にしておく必要がある。リポジトリのサンプルだと`app.foobar`といった感じ。

### AWS CLIのセットアップ

IAMでIAMとLambdaなどにアクセスできるユーザーを作っておく。aws configure時にリージョンも聞かれるので`ap-northeast-1`を入力。output formatはデフォのままで良いと思う。

デフォの認証情報については[設定ファイルと認証情報ファイル - AWS Command Line Interface](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-files.html)を参照。

```
$ brew install awscli
$ aws configure
```

つくった物をzipで固める。

```
$ zip -r function.zip app.rb vendor
```

aws cliでデプロイする

```
$ aws lambda update-function-code --function-name [関数名] --zip-file fileb://function.zip
```

## 参考

- https://qiita.com/kiitan/items/4bdc530c66d6cdfbd294
- https://qiita.com/harhogefoo/items/ecac4b0fa9475a8bd393