export LANG=en_US.UTF-8
SVN=/usr/bin/svn
WEB=/data/www2/zgtcb
$SVN update $WEB --username majianglin --password h-.c3aV2 --no-auth-cache
chown -R www:www $WEB

exit
