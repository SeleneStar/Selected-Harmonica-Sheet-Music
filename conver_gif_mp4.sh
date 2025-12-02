#!/bin/bash

# 遍历当前目录下的所有gif文件（包括文件名中有空格的）
find . -maxdepth 1 -type f -name "*.gif" -print0 | while IFS= read -r -d '' file; do
    # 获取不带扩展名的文件名
    filename=$(basename -- "$file")
    filename="${filename%.*}"
    
    # 构建输出文件名
    output_file="${filename}.mp4"
    
    # 执行ffmpeg命令
    ffmpeg -stream_loop -1 -i "$file" -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -t 15 -c:v libx264 -pix_fmt yuv420p "$output_file"

    # 打印
    echo "已转换: $file -> $output_file"
done

echo "转换完成！"

