# fluentd-custom Cookbook
The cookbook for installing official `td-agent` package.

## How to use

## Just installing td-agent

Just put the below line in your node file:

```
{
  "run_list": [
      recipe['fluentd-custom']
  ]
}
```

## Receive log forwarding from remote hosts

Just put the below lines in your node file:

```
{
  "td_agent":{
    "forward": true
  },
  "run_list": [ ... snip ... ]
}
```
