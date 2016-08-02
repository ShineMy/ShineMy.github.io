---
layout: post
title: ESLint 从安装到使用
category: another
---

# ESLint

---

## 由来：

Lint工具用于检查代码的语法是否正确、风格是否符合要求。

JavaScript语言的最早的Lint工具，是Douglas Crockford开发的JSLint。由于该工具所有的语法规则，都是预设的，用户无法改变。所以，很快就有人抱怨，JSLint不是让你写成正确的JavaScript，而是让你像Douglas Crockford一样写JavaScript。

JSHint可以看作是JSLint的后继者，最大特定就是允许用户自定义自己的语法规则，写在项目根目录下面的.jshintrc文件。

JSLint和JSHint同时检查你的语法和风格。另一个工具JSCS则是只检查语法风格。

最新的工具ESLint不仅允许你自定义语法规则，还允许用户创造插件，改变默认的JavaScript语法，比如支持ES6和JSX的语法。

## 基本用法：

#### 1. 安装

`$ npm install -g eslint`

#### 2. 设置配置文件

`$ eslint --init`

#### 3. 使用

`$ eslint index.js`

## 配置方式：

可以通过以下三种方式配置 ESLint:

- 使用 `.eslintrc` 文件

- 在 `package.json` 中添加 `eslintConfig` 配置块

- 直接在代码文件中定义

#### `.eslintrc` 文件示例：

    {
      "env": {
        "browser": true,
      },
      "parserOptions": {
        "ecmaVersion": 6,
        "ecmaFeatures": {
          "jsx": true
        }
      },
      "globals": {
        "angular": true,
      },
      "rules": {
        "camelcase": 2,
        "curly": 2,
        "brace-style": [2, "1tbs"],
        "quotes": [2, "single"],
        "semi": [2, "always"],
        "space-in-brackets": [2, "never"],
        "space-infix-ops": 2,
      }
    }

`.eslintrc` 放在项目根目录，则会应用到整个项目；如果子目录中也包含 `.eslintrc` 文件，则子目录会忽略根目录的配置文件，应用该目录中的配置文件。这样可以方便地对不同环境的代码应用不同的规则。

#### `package.json` 示例：

    {
      "name": "mypackage",
      "version": "0.0.1",
      "eslintConfig": {
        "env": {
          "browser": true,
          "node": true
        }
      }
    }

#### 文件内配置：

文件内通过注释配置，代码文件内配置的规则会覆盖配置文件里的规则。

禁用 ESLint：

    /* eslint-disable */
    var obj = { key: 'value', }; // I don't care about IE8
    /* eslint-enable */                    **

禁用一条规则：

    /*eslint-disable no-alert */
    alert('doing awful things');  
    /* eslint-enable no-alert */           **

调整规则：

    /* eslint indent: 1 */
    // Make this just a warning, not an error
    var obj = { key: 'value', }            **

## 插件使用：

ESLint 内置的规则不可能包罗所有需求。可以通过插件实现自定义规则，在 NPM 上以 eslintplugin 为关键词，可以搜索到很多插件，包括 `eslint-plugin-react`.

以 `eslint-plugin-react` 为例，安装以后，需要在 ESLint 配置中开启插件，其中 eslint-plugin- 前缀可以省略：

    {
      "plugins": [
          "react"
      ]
    }

接下来开启 ESLint JSX 支持（ESLint 内置选项）：

    {
      "ecmaFeatures": {
        "jsx": true
      }
    }

然后就可以配置插件提供的规则了：

    {
      "rules": {
        "react/display-name": 1,
        "react/jsx-boolean-value": 1
      }
    }

**注意**：全局安装的 ESLint 只能使用全局安装的插件。本地安装的 ESLint 不仅可以使用本地安装的插件还可以使用全局安装的插件。

## 预置规则：

#### [Airbnb](https://github.com/airbnb/javascript)

自己设置所有语法规则，是非常麻烦的。所以，ESLint提供了预设的语法样式，比较常用的Airbnb的语法规则。由于这个规则集涉及ES6，所以还需要安装Babel插件。

`$ npm i -g babel-eslint eslint-config-airbnb`

安装完成后，在.eslintrc文件中注明，使用Airbnb语法规则。

    {
        "extends": "eslint-config-airbnb"
    }

你也可以用自己的规则，覆盖预设的语法规则。

    {
      "extends": "eslint-config-airbnb",
      "rules": {
        "no-var": 0,
        "no-alert": 0
      }
    }

上面的.eslintrc文件定义了两条语法规则。每个语法规则后面，表示这个规则的级别。

- 0 ：关闭这条规则。
- 1 ：违反这条规则，会抛出一个警告。
- 2 ：违反这条规则，会抛出一个错误。

## 语法规则：

#### 1.indent

indent规则设定行首的缩进，默认是四个空格。下面的几种写法，可以改变这个设置。

    // 缩进为4个空格（默认值）
    "indent": 2

    // 缩进为2个空格
    "indent": [2, 2]

    // 缩进为1个tab键
    "indent": [2, "tab"]

    // 缩进为2个空格，
    // 同时，switch...case结构的case也必须缩进，默认是不打开的
     "indent": [2, 2, {"SwitchCase": 1}]

#### 2.no-unused-vars

不允许声明了变量，却不使用。

    "no-unused-vars": [2, {"vars": "local", "args": "after-used"}]

上面代码中，vars字段表示只检查局部变量，允许全局变量声明了却不使用；args字段表示函数的参数，只要求使用最后一个参数，前面的参数可以不使用。

#### 3.no-alert

禁用alert

    "no-alert": "error"

#### [官方文档](http://eslint.org/docs/rules/)

## 工作流集成：

#### 1. 编辑器集成

- **Atom** 安装 **linter-eslint**

- **WebStorm** 启用 **eslint**

#### 2. 构建系统集成

>- Grunt: grunt-eslint

>- Gulp: gulp-eslint

>- Mimosa: mimosa-eslint

>- Broccoli: broccoli-eslint

>- Browserify: eslintify

>- Webpack: eslint-loader

>- Rollup: rollup-plugin-eslint

>- Ember-cli: ember-cli-eslint

>- Sails.js: sails-hook-eslint

>- Start: start-eslint

在 Gulp 中使用：

    var gulp = require('gulp');  
    var eslint = require('gulp-eslint');

    gulp.task('lint', function() {  
      return gulp.src('client/app/**/*.js')
        .pipe(eslint())
        .pipe(eslint.format());
    });
