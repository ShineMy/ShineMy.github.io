---
layout:     post
title:      "livereload 用法及原理讲解"
subtitle:   "explain the usage and principle for livereload"
date:       2016-01-15
author:     "Tmx"
header-img:    img/post-bg-2015.jpg
tags:
    - 前端开发
---


# livereload用法及原理讲解

---

首先，说一下livereload是什么：livereload这款软件的作用是在你更新代码并保存时，浏览器中对应的页面会自动刷新。以防止出现下图情况：

![](img/livereload-1.png)

它可以扩展到浏览器中，使用起来很方便。

## 下载

<http://livereload.com>这个是下载地址；下载后点击下面的链接把livereload添加到chrome上：<https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei?hl=zh-CN>。

## 用法

#### 第一部分：配置服务器

1.XAMPP传送门<https://www.apachefriends.org/zh_cn/index.html> 下载安装。

2.开启Apache服务器（勾选前面的方框变成"√"），记住你的端口号（Port(s)下面的数字）。最终如下图：

![](img/livereload-2.png)

#### 第二部分：livereload的用法

1.打开你的项目并打开对应页面，注意不是本机地址，应为127.0.0.1:8090/index.html。

（冒号后面的是端口号，我的是8090，改成你自己的；"/"后面的是你的文件所在路径。）

2.打开livereload，点击“+add”按钮，找到你的项目。这时你会看到左侧出现了你的项目名称，点击。

3.在chrome扩展部分找到livereload的图标，点击，若图标变化则成功开启。

（注意：要确保你的项目是在服务器上运行的，否则无效，原因看下面原理）

最终如下图：

![](img/livereload-3.png)

**原理**：livereload是基于socket通信的，启用时livereload会开启一个服务器，和你项目所在的服务器之间进行通信，当你的代码发生变化时，livereload将监听到的信息发送给浏览器，使浏览器页面刷新。
