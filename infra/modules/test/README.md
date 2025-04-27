# GitHub Actions動作確認用リソースです

### メモ

```
# モジュール追加後
terraform init

# 変更プランファイル出力
terraform plan -no-color -out=tfplan

# 差分があるかフラグ
terraform show -json tfplan | jq '.resource_changes | any(.change.actions[] != "no-op")'
```
