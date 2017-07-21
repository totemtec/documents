# NGINX rewrite使用方法

参考文档
> http://nginx.org/en/docs/http/ngx_http_rewrite_module.html 
> http://dengxi.blog.51cto.com/4804263/1842099
> http://www.cnblogs.com/zhang-shijie/p/5453249.html

**ngx_http_rewrite_module模块用PCRE正则表达式改变请求路径，返回重定向，可以使用if条件**

如果在server级别设置该选项，那么他们将在location之前生效。
如果在location还有更进一步的重写规则，location部分的规则依然会被执行。
如果这个URI重写是因为location部分的规则造成的，那么location部分会再次被执行作为新的URI。

这个循环会执行10次，然后Nginx会返回一个500错误。



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








