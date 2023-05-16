# GWF Blogger (blog) Module

[Home](../README.md) | [GWF Chain](./gwf.md) | [Profiles](./profile.md) | [Blogger](./blog.md) | [Squares](./sqrz.md) | [Fund Me](./fund.md)

## Overview

This module allows users to have a blog under thier profile page


### Module Parameters

| Name             | Type   | Default | Description                                         |
| ---------------- | ------ | ------- | --------------------------------------------------- |
| `enabled`        | `bool` | true    | Used to Enable or Disable the module.               |
| `payperview`     | `int`  | 0       | The amount of GWF to charge for each view of a post |

## Ignite Scaffold

```sh
ignite scaffold module blog --params enabled:bool,payperview:int --dep account,bank
```

```sh
ignite scaffold message createBlogPost title:string body:string tags:array.string imgurl:string --module blog --yes
```

```sh
ignite scaffold query posts --response title,body,tags,imgurl --module blog --yes
```


### Testing

```sh
gwfchaind tx blog create-blog-post Hello Hello_World tag1,tag2 earth.jpg --from alice
```

