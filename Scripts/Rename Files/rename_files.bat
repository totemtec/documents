:: 编码要跟Windows编码一致，Win7上使用 gb2312
   @echo off
   setlocal enabledelayedexpansion

   set "folderPath=%cd%"
   set oldString=.《欧阳越高思竞赛数学精讲》3年级上册
   set newString=.

   for %%a in (*) do (
       set "filename=%%a"
       set "newfilename=!filename:%oldString%=%newString%!"
       if not "!filename!"=="!newfilename!" (
           ren "%%a" "!newfilename!"
       )
   )

   echo 替换完成!
   pause