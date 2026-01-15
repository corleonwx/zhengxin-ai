#!/bin/bash

# 正心AI自动上传脚本
# 每天晚上12点自动执行

cd ~/zhengxin-ai || exit 1

# 检查是否有更改（包括未跟踪文件）
if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
    echo "没有新更改需要上传"
    exit 0
fi

# 添加所有更改
git add .

# 生成commit信息
TIME=$(date +"%Y-%m-%d %H:%M")
COMMIT_MSG="自动上传: ${TIME} 的开发进度"

# 提交更改
git commit -m "$COMMIT_MSG"

# 推送到GitHub
git push origin main

# 记录日志
echo "[$TIME] 自动上传完成" >> ~/zhengxin-ai/upload.log