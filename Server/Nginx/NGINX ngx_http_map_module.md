# NGINX map使用方法

参考文档
> http://nginx.org/en/docs/http/ngx_http_map_module.html

**ngx_http_map_module模块用来创建一个变量，一般都是从另一个变量计算出来的**

``` nginx.conf
语法:	map string $variable { ... }
默认值:	无
上下文:	http
```
map为一个变量设置的映射表。映射表由两列组成，匹配模式和对应的值。

在 map 块里的参数指定了源变量值和结果值的对应关系。

匹配模式可以是一个简单的字符串或者正则表达式，使用正则表达式要用('~')。

一个正则表达式如果以 “~” 开头，表示这个正则表达式对大小写敏感。以 “~*”开头，表示这个正则表达式对大小写不敏感。

#####例如: 
``` nginx.conf
map $http_user_agent $mobile {
    default       0;
    "~Opera Mini" 1;
}

map $http_host $name {
    hostnames;

    default       0;

    example.com   1;
    *.example.com 1;
    example.org   2;
    *.example.org 2;
    .example.net  3;
    wap.*         4;
}
```

参数string是变量来源  
参数$variable是创建好的变量

> default 0;  
> 是指变量$mobile默认值为0，如果不指定，默认为空字符串
>
> "~Opera Mini" 1;  
> 是指在$http_user_agent变量值中一旦发现"Opera_Mini"字符串，$mobile赋值为1
>
> hostnames;  
> 允许用前缀或者后缀掩码指定域名作为源变量值。
> 这个参数必须写在值映射列表的最前面。
>
> include file  
> 指令可以引用别的文件
>
> volatile  
> 指令表示该变量不会缓存

如果匹配到多个特定的变量，如掩码和正则同时匹配，那么会按照下面的顺序进行选择：
1. 没有掩码的字符串
2. 最长的带前缀的字符串，例如: “*.example.com”
3. 最长的带后缀的字符串，例如：“mail.*”
4. 按顺序第一个先匹配的正则表达式 （在配置文件中体现的顺序）
5. 默认值


### PCRE正则表达式拾取/捕获

PCRE正则表达式中能包含命名参数或者占位参数，参数取得的值，其他指令可能会用到

语法参考

> http://www.pcre.org/original/doc/html/pcresyntax.html   CAPTURING章节
>
> http://nginx.org/en/docs/http/server_names.html#regex_names

参数拾取/捕获

```
(...)           小括号是拾取组，使用$1,$2来访问
(?<name>...)    命名拾取组
(?'name'...)    命名拾取组
(?:...)         非拾取组
(?|...)         非拾取组; 重置拾取组编号

```







