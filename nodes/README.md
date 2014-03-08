# jsonファイルの書き方
jsonファイルの書き方を紹介します。

## attribute の指定方法
このような形で attribute を上書きします:

```
{
  "nginx": {
    "port": 80
},
"run_list":[
  "yum::epel",
  "recipe[setup]"
]}
```

### [具体例] Rubyのインストールをする
こんな風に書きますよー:

```
{
  "kazu634":{
    "ruby_support": true
  },
  "run_list": [
    "recipe[kazu634]"
    ]
}
```

### [具体例] www3232u.sakura.ne.jp.json

```
{
  "kazu634":{
    "ruby_support": true
  },
  "run_list": [
    "role[base]",
    "recipe[wordpress]",
    "recipe[tech]"
    ]
}
```

### [具体例] www6308ui.sakura.ne.jp

```
{
  "run_list": [
    "role[base]",
    "recipe[redmine]",
    "recipe[nagios]"
    ]
}
```

### [具体例] ec2-54-238-50-194.ap-northeast-1.compute.amazonaws.com

```
{
  "run_list": [
    "role[aws]",
    "recipe[jenkins]"
  ]
}
```
