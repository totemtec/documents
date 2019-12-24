FFmpeg导出图片

ffmpeg -ss 00:00:09.123 -i input.mp4 -vframes 1 output.jpg

-ss 指定截图时间。放在第1个参数，这样处理更快，按照时间秒的周边找关键帧。如果放在-i后面就不是找关键帧了，是精确时间点，这样需要一帧一帧处理，慢

-q:v 1 指定图片质量，1质量最高，31压缩率最高，一般2-5比较好

-vf fps=1 image_%d.png 每秒输出1张，指定图片名后缀

-vf fps=1/60 img%03d.jpg 每分钟输出1张，指定图片名后缀

-vf "select='eq(pict_type,PICT_TYPE_I)'" -vsync vfr image_%d.png 导出每个关键帧

-vframes 1 只处理1帧，单独输出1帧

-vsync   视频同步方法
vfr     可变帧率


例子：

1. 为mp4文件添加预览图片

# ffmpeg -i in.mp4 -i cover.png -map 0 -map 1 -c copy -c:v:1 png -disposition:v:1 attached_pic out.mp4



