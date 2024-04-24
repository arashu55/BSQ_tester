#!/bin/bash

# 引数から実行ディレクトリを取得、指定がない場合はデフォルトでカレントディレクトリを使用
exec_dir="${1:-.}"

# resultディレクトリの作成
last_dir=$(find . -type d -name 'result*' | sort -V | tail -n 1)
if [ -n "$last_dir" ]; then
  num=$(basename "$last_dir" | sed 's/result//')
  next_num=$((num+1))
else
  next_num=1
fi
new_dir="result$(printf "%02d" $next_num)"
mkdir "$new_dir"
echo "Created directory: $new_dir"

# 指定されたディレクトリ内のファイルに対してループ
for file in "$exec_dir"/*; do
  if [ -f "$file" ]; then
    filename=$(basename "$file")
    # bsqコマンドの実行と結果の保存
    ./bsq "$file" > "$new_dir/$filename" 2>&1
  fi
done

echo "All files have been processed and saved in $new_dir."
