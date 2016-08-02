<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8" />
<meta name="author" content="{{ site.meta.author.name }}" />
<meta name="keywords" content="{{ page.tags | join: ',' }}" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>{{ site.name }}{% if page.title %} / {{ page.title }}{% endif %}</title>
<link href="http://{{ site.host }}/feed.xml" rel="alternate" title="{{ site.name }}" type="application/atom+xml" />
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" />
<link rel="stylesheet" type="text/css" href="/assets/css/site.css" />
<link rel="stylesheet" type="text/css" href="/assets/css/code/github.css" />
{% for style in page.styles %}<link rel="stylesheet" type="text/css" href="{{ style }}" />
{% endfor %}
</head>

<body class="{{ layout.class }}">

<div class="main">
	{{ content }}

	<footer>
		<p>&copy; Since 2016</p>
	</footer>
</div>

<aside>
	<h2><a href="/">{{ site.name }}</a><a href="/feed.xml" class="feed-link" title="Subscribe"><i class="fa fa-rss-square"></i></a></h2>

	<nav class="block">
		<ul>
		{% for category in site.custom.categories %}<li class="{{ category.name }}"><a href="/category/{{ category.name }}/">{{ category.title }}</a></li>
		{% endfor %}
		</ul>
	</nav>

	<div class="block block-about">
		<h3>关于我</h3>
		<figure>
			{% if site.meta.author.gravatar %}<img src="{{ site.meta.gravatar}}{{ site.meta.author.gravatar }}?s=48" />{% endif %}
			<figcaption><strong>{{ site.meta.author.name }}</strong></figcaption>
		</figure>
		<p>致力于Node全栈，虽然路还很远。</p>
	</div>

	<div class="block block-contact">
		<h3>联系我</h3>
		<ul>
			<li><span>电话</span> 15244659901</li>
			<li><span>邮箱</span> tmx_web@163.com</li>
			<li><span>github</span> <a href="ShineMy.github">ShineMy.github</a></li>
		</ul>
	</div>
</aside>

<script src="http://elfjs.qiniudn.com/code/elf-0.5.0.min.js"></script>
<script src="http://yandex.st/highlightjs/7.3/highlight.min.js"></script>

<script src="/assets/js/site.js"></script>
{% for script in page.scripts %}<script src="{{ script }}"></script>
{% endfor %}
<script>
site.URL_GOOGLE_API = '{{site.meta.gapi}}';
site.URL_DISCUS_COMMENT = '{{ site.meta.author.disqus }}' ? 'http://{{ site.meta.author.disqus }}.{{ site.meta.disqus }}' : '';

site.VAR_SITE_NAME = "{{ site.name | replace:'"','\"' }}";
site.VAR_GOOGLE_CUSTOM_SEARCH_ID = '{{ site.meta.author.gcse }}';
site.TPL_SEARCH_TITLE = '#{0} / 搜索：#{1}';
site.VAR_AUTO_LOAD_ON_SCROLL = {{ site.custom.scrollingLoadCount }};
</script>
</body>
</html>
