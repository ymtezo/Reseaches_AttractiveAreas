# Reseaches_AttractiveAreas
自分向け地域の成功指数に関して優位なものを探す。

## 概要

このリポジトリでは、地域の成功を測定する指標と地域特性データを体系的に定義し、地域研究のための変数セットを提供します。

## ファイル構成

- **`variables_definition.R`**: アウトカム変数と地域特性変数の定義ファイル
  - `outcome_variables`: 地域の成功を測る51個のアウトカム変数（7カテゴリ）
  - `regional_characteristic_variables`: 地域ごとに取得可能な96個の特性変数（14カテゴリ）

- **`VARIABLES_README.md`**: 変数定義の詳細ガイドとドキュメント

- **`example_usage.R`**: 変数定義の使用例を示すサンプルスクリプト

## 使い方

### 基本的な使用方法

```r
# 変数定義を読み込む
source("variables_definition.R")

# アウトカム変数のカテゴリを確認
names(outcome_variables)

# 地域特性変数のカテゴリを確認
names(regional_characteristic_variables)

# 具体的な変数の詳細を見る
outcome_variables$government_statistics$`地域内総生産（GDP）`
```

### サンプルスクリプトの実行

```bash
Rscript example_usage.R
```

## 変数の概要

### アウトカム変数（outcome_variables）

地域が成功しているかを測定するための指標：
- 政府統計・公的機関データ（GDP、人口増減率、雇用指標など）
- 家計調査データ（趣味娯楽費割合、貯蓄率など）
- アンケート・主観的指標（幸福度、生活満足度など）
- 民間企業・研究機関データ（地価、観光客数など）
- 環境・インフラ指標
- デジタル・通信指標
- 独自指標（若年層流入率、文化施設充実度など）

### 地域特性変数（regional_characteristic_variables）

地域ごとに取得可能な特性データ：
- 地理・位置情報
- 交通インフラ
- 産業構造
- 人口構成
- 教育・研究機関
- 医療・福祉
- 商業・サービス施設
- 文化・娯楽・スポーツ施設
- 住宅・不動産
- 環境・自然
- 行政・政治
- デジタル・ICT
- 観光・地域資源
- 近隣・広域関係

詳細は[VARIABLES_README.md](VARIABLES_README.md)を参照してください。

## データソース

主要な公的統計データソース：
- [e-Stat（政府統計の総合窓口）](https://www.e-stat.go.jp/)
- [内閣府 県民経済計算](https://www.esri.cao.go.jp/jp/sna/data/data_list/kenmin/files/files_kenmin.html)
- [総務省 住民基本台帳](https://www.soumu.go.jp/main_sosiki/jichi_gyousei/daityo/)
- [国土交通省 国土数値情報](https://nlftp.mlit.go.jp/ksj/)

## ライセンス

このプロジェクトはMITライセンスの下で公開されています。詳細は[LICENSE](LICENSE)ファイルを参照してください。
