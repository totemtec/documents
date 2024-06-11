chcp 65001
@echo off


@rem 此脚本用来执行 Nexus 同步前的数据导出工作
@rem 此脚本运行在 majianglin 我的 Windows 11 电脑上 
@rem 此脚本执行前，需要手动在 Nexus 管理端手动执行备份任务 BackUpForLocal，完成后才能运行此脚本
@rem 运行完成后，本目录下就会有 archive.tar.gz 文件，文件会比较大

@rem 本脚本文件编码 UTF-8，换行符使用 Windows 风格，\r\n
@rem 在 IDEA Terminal 中运行时，需要在右下角将 Line Separator 改为 CRLF - Windows(\r\n)
@rem 脚本 backup.sh 使用UTF-8编码，使用 Unix and Mac 风格的换行符 \n

@rem 172.28.103.161 是本地 Nexus 服务器 IP

set local_nexus=172.28.103.161

@echo ******
@echo 开始备份前，请在 http://%local_nexus%:8081/#admin/system/tasks 手动执行备份任务 BackUpForLocal
@echo ******


SET /P confirm=请确认已经手动完成了 nexus 备份任务 BackUpForLocal (yes)：
@echo ******
IF /I "%confirm%" NEQ "yes" GOTO exit

call:backup
goto:eof

:backup
    @echo 备份文件打包中，请耐心等待
	ssh root@%local_nexus% "docker stop --time=120 nexus && cd /opt/nexus/data && rm -rf archive.tar.gz && tar -czf archive.tar.gz BackUp keystores blobs && docker start nexus"
	@echo 备份文件打包完成。
	ping 127.0.0.1 -n 3 > nul
	@echo 拉取备份文件到我的电脑...
	scp root@%local_nexus%:/opt/nexus/data/archive.tar.gz .
	@echo 本地文件保存完成，文件名 archive.tar.gz
	@echo 请将备份文件 archive.tar.gz 传输到内网 /nfs/home/majianglin/nexus/ 目录下
	pause
	goto:eof
	
:exit
	@echo 需要先手动执行 nexus 备份任务 BackUpForLocal
	@echo ******
	goto:eof