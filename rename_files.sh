#!/bin/bash

counter=1
for file in test_case3/*; do
    filename=$(basename "$file")
    # 拡張子.txtがあれば取り除く
    filename="${filename%.txt}"
    # 新しいファイル名をフォーマットしてナンバリング
    newname=$(printf "test_case3/%02d_%s" "$counter" "$filename")
    # ファイルをリネーム
    mv "$file" "$newname"
    ((counter++))
done

echo "Files have been renamed."

