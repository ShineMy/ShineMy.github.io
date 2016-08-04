---
layout:     post
title:      "浅谈JS模块化"
subtitle:   "JS modularity"
date:       2016-04-04
author:     "Tmx"
header-img:    img/post-bg-js-module.jpg
tags:
    - 前端开发
    - js
---


# 浅谈JS模块化

---

## 一、模块化的由来

什么是模块?模块就是实现特定功能的一组方法。

**原始写法**

    function add(a, b) {
      return a + b;
    }

    function divide(a, b) {
      return a / b;
    }

这两个函数就可以组成一个模块，功能是实现一些数学运算，这种做法的缺点很明显："污染"了全局变量，无法保证不与其他模块发生变量名冲突，而且模块成员之间看不出直接关系。

**对象写法**

    var math = {
      _count: 0，
      add: function(a, b) {
        return a + b;
      },
      divide: function(a, b) {
        return a / b;
      }
    }

这样的写法会暴露所有模块成员，内部状态可以被外部改写。比如，外部代码可以直接改变内部计数器的值。

    math._count = 5;

立即执行函数写法

    var math = (function() {
      var _count = 0;

      return {
        add: function(a, b) {
          return a + b;
        },
        divide: function(a, b) {
          return a / b;
        }
      };
    })();

使用上面的写法，外部代码无法读取内部的_count变量。

    console.info(math._count); //undefined

利用自执行函数的特点，我们还可以很方便地为模块添加方法：

    var math = (function(module) {
      module.subtract = function(a, b) {
        return a - b;
      }
    })(math);

math就是JS模块的基本写法。

## 二、commonJS

CommonJS是为了弥补JavaScript标准库过少的缺点而产生的，由于JS没有模块机制，CommonJS就帮助JS实现模块的功能。CommonJS在模块中定义方法要借助一个全局变量exports，它用来生成当前模块的API：

    /* math module */

    exports.add = function(a, b) {
      return a + b;
    };

要加载模块就要使用CommonJS的一个全局方法require()。加载之前实现的math模块像这样：

    var math = require('math');

加载后math变量就是这个模块对象的一个引用，要调用模块中的方法就像调用普通对象的方法一样了：

    var math = require('math');
    math.add(1, 3);

CommonJS就是一个模块加载器，可以方便地对JavaScript代码进行模块化管理。但它也有缺点，它在设计之初并没有完全为浏览器环境考虑，浏览器环境的特点是所有的资源，不考虑本地缓存的因素，都需要从服务器端加载，加载的速度取决于网络速度，而CommonJS的模块加载过程是同步阻塞的。也就是说如果math模块体积很大，网速又不好的时候，整个程序便会停止，等待模块加载完成。

## 三、AMD和CMD规范

**AMD**

它的特点便是异步加载，模块的加载不会影响其他代码的运行。所有依赖于某个模块的代码全部移到模块加载语句的回调函数中去。AMD的require()语句接受两个参数：

    // require([module], callback)
    require(['math'], function(math) {
      math.add(1, 3);
    });

在回调函数中，可以通过math变量引用模块。

AMD规范也规定了模块的定义规则，使用define()函数。

    define(id?, dependencies?, factory);

它接受三个参数：

id

这是一个可选参数，相当于模块的名字，加载器可通过id名加载对应的模块。如果没有提供id，加载器会将模块文件名作为默认id。

dependencies

可选，接受一个数组参数，传入当前对象依赖的对象id。

factory

回调函数，在依赖模块加载完成后会调用，它的参数是所有依赖模块的引用。回调函数的返回值就是当前对象的导出值。

用AMD规范实现一个简单的模块可以这样：

    define('foo', ['math'], function(math) {
      return {
        increase: function(x) {
          return math.add(x, 1);
        }
      };
    });

如果省去id和dependencies参数的话，就是一个完全的匿名模块。factory的参数将为默认值require，exports和module加载器将完全通过文件路径的方式加载模块，同时如果有依赖模块的话可通过require方法加载。

    define(function(require, exports, module) {
      var math = require('math');

      exports.increase = function(x) {
        return math(x, 1);
      };
    });

对于某些没有按照AMD规范编写的模块，比如jQuery，来说，要使它们能被加载器加载，需要用shim方法为其配置一些属性。在main模块中，用require.config()方法：

    require.config({
      shim: {
        'jquery': {
          exports: '$'
        },
        'foo': {
          deps: [
            'bar',
            'jquery'
          ],
          exports: 'foo'
        }
      }
    });

之后再用加载器加载就可以了。

define

与AMD规范不同的是CMD规范中不使用id和deps参数，只保留factory。其中：
1.factory接收对象/字符串时，表明模块的接口就是对象/字符串。

    define({ 'foo': 'bar' });

    define('My name is classicemi.');

define.cmd

其值为一个空对象，用于判断页面中是否有CMD模块加载器。

    if (typeof define === 'function' && define.cmd) {
      // 使用CMD模块加载器编写代码
    }

require

此函数同样用于获取模块接口。如需异步加载模块，使用require.async方法。

    define(function(require, exports, module) {
      require.async('math', function(math) {
        math.add(1, 2);
      });
    });

我们可以发现，require(id)的写法和CommonJS一样是以同步方式加载模块。要像AMD规范一样异步加载模块则使用define.async方法。

exports

此方法用于模块对外提供接口。

    define(function(require, exports, module) {
      // 对外提供foo属性
      exports.foo = 'bar';

      // 对外提供add方法
      exports.add = function(a, b) {
        return a + b;
      }
    });

提供接口的另一个方法是直接return包含接口键值对的对象：

    define(function(require, exports, module) {
      return {
        foo: 'bar',
        add: function(a, b) {
          return a + b;
        }
      }
    });

但是注意，不能用exports输出接口对象：

    define(function(require, exports, module) {
      exports = {
        foo: 'bar',
        add: function(a, b) {
          return a + b;
        }
      }
    });

这样写是错误的！
替代方式是这样写：

    define(function(require, exports, module) {
      module.exports = {
        foo: 'bar',
        add: function(a, b) {
          return a + b;
        }
      }
    });
