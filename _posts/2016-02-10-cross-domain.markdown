---
layout:     post
title:      "跨域方式分享"
subtitle:   "share the way to cross-domain"
date:       2016-02-10
author:     "Tmx"
header-img:    img/post-bg-unix-linux.jpg
tags:
    - 前端开发
    - JavaScript
    - ajax
---


# 跨域方式分享

---

浏览器的同源策略：其限制之一就是第一种方法中我们说的不能通过ajax的方法去请求不同源中的文档。 它的第二个限制是浏览器中不同域的框架之间是不能进行js的交互操作的。

<http://www.cnblogs.com/2050/p/3191744.html>

![](/img/cross-domain-1.png)

#### 一、通过jsonp跨域（在js中，我们直接用XMLHttpRequest请求不同域上的数据时，是不可以的。但是，在页面上引入不同域上的js脚本文件却是可以的，jsonp正是利用这个特性来实现的。）

**本地文件：a.html**

![](/img/cross-domain-2.png)

我们看到获取数据的地址后面还有一个callback参数，按惯例是用这个参数名，但是你用其他的也一样。当然如果获取数据的jsonp地址页面不是你自己能控制的，就得按照提供数据的那一方的规定格式来操作了。

**外部文件：<http://example.com/data.php>**

![](/img/cross-domain-3.png)

最终那个页面输出的结果是:

![](/img/cross-domain-4.png)

知道jsonp跨域的原理后我们就可以用js动态生成script标签来进行跨域操作了，而不用特意的手动的书写那些script标签。如果你的页面使用jquery，那么通过它封装的方法就能很方便的来进行jsonp操作了。

![](/img/cross-domain-5.png)

#### 2、通过修改document.domain来跨子域(两个页面的document.domain都设成相同的域名)

我们只要把 <http://www.example.com/a.html> 和 <http://example.com/b.html> 这两个页面的document.domain都设成相同的域名就可以了。但要注意的是，document.domain的设置是有限制的，我们只能把document.domain设置成自身或更高一级的父域，且主域必须相同。

例如：a.b.example.com 中某个文档的document.domain 可以设成a.b.example.com、b.example.com 、example.com中的任意一个，但是不可以设成 c.a.b.example.com,因为这是当前域的子域，也不可以设成baidu.com,因为主域已经不相同了。

本地页面：在页面 <http://www.example.com/a.html> 中设置document.domain:

![](/img/cross-domain-6.png)

远程页面：

![](/img/cross-domain-7.png)

注意点：

不过如果你想在 <http://www.example.com/a.html> 页面中通过ajax直接请求 <http://example.com/b.html> 页面，即使你设置了相同的document.domain也还是不行的，所以修改document.domain的方法只适用于不同子域的框架间的交互。如果你想通过ajax的方法去与不同子域的页面交互，除了使用jsonp的方法外，还可以用一个隐藏的iframe来做一个代理。原理就是让这个iframe载入一个与你想要通过ajax获取数据的目标页面处在相同的域的页面，所以这个iframe中的页面是可以正常使用ajax去获取你要的数据的，然后就是通过我们刚刚讲得修改document.domain的方法，让我们能通过js完全控制这个iframe，这样我们就可以让iframe去发送ajax请求，然后收到的数据我们也可以获得了。

#### 3、使用window.name来进行跨域

本地：

![](/img/cross-domain-8.png)

远程：

![](/img/cross-domain-9.png)

#### 4、使用HTML5中新引进的window.postMessage方法来跨域传送数据

![](/img/cross-domain-10.png)

![](/img/cross-domain-11.png)
