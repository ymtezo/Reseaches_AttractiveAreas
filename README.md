# Reseaches_AttractiveAreas

地域創生の成功因子分析研究 / Regional Revitalization Success Factor Analysis

## 概要 / Overview

本プロジェクトは、Rを用いて地域創生に成功しているとするのに必要なアウトカムを探り、それに影響を与えた因子を推定する研究群です。

This project uses R to explore the necessary outcomes that indicate successful regional revitalization and to estimate the factors that influence those outcomes.

## 研究の目的 / Research Objectives

1. **アウトカム指標の探索**: 地域創生の成功を示す適切なアウトカム指標を特定する
2. **因子の分析**: 成功に影響を与える地域特性や施策を分析する
3. **影響度の推定**: 統計モデルを用いて各因子の影響度を定量的に推定する
4. **知見の可視化**: 分析結果を分かりやすく可視化し、政策提言につなげる

## プロジェクト構造 / Project Structure

```
Reseaches_AttractiveAreas/
├── R/
│   ├── main_analysis.R              # メイン実行スクリプト
│   ├── scripts/
│   │   ├── 01_data_collection.R     # データ収集スクリプト
│   │   ├── 02_outcome_exploration.R # アウトカム探索スクリプト
│   │   ├── 03_factor_analysis.R     # 因子分析スクリプト
│   │   └── 04_visualization.R       # 可視化スクリプト
│   ├── data/                        # データファイル（自動生成）
│   │   ├── outcome_indicators.csv
│   │   ├── regional_factors.csv
│   │   └── classified_regions.csv
│   └── output/                      # 分析結果・図表（自動生成）
│       ├── *.csv
│       └── *.png
├── README.md
└── LICENSE
```

## 使用方法 / Usage

### 前提条件 / Prerequisites

- R (バージョン 4.0 以上推奨)
- RStudio（推奨、必須ではない）

### 必要なパッケージ / Required Packages

以下のパッケージが自動的にインストールされます：

```r
tidyverse, here, corrplot, psych, FactoMineR, 
randomForest, caret, MASS, pROC, ggplot2, 
patchwork, scales, lm.beta
```

### 実行方法 / How to Run

#### 方法1: すべての分析を一括実行

```r
# Rコンソールまたはターミナルで
Rscript R/main_analysis.R
```

または、R/RStudioで：

```r
source("R/main_analysis.R")
```

#### 方法2: 個別スクリプトの実行

```r
# データ収集のみ
source("R/scripts/01_data_collection.R")

# アウトカム探索のみ
source("R/scripts/02_outcome_exploration.R")

# 因子分析のみ
source("R/scripts/03_factor_analysis.R")

# 可視化のみ
source("R/scripts/04_visualization.R")
```

## 分析内容 / Analysis Content

### 1. アウトカム指標 / Outcome Indicators

地域創生の成功を測る指標：

- **人口増減率** (Population Change Rate): 地域の人口動態
- **若年層人口比率** (Youth Population Ratio): 若年層の定着度
- **新規事業所数** (New Establishments): 経済活性度
- **観光客数** (Number of Tourists): 地域の魅力度
- **平均所得** (Average Income): 経済的豊かさ
- **移住者数** (Number of Immigrants): 地域への流入
- **雇用率** (Employment Rate): 雇用の安定性

### 2. 影響因子 / Influencing Factors

分析対象となる地域特性・施策：

- **自治体予算** (Municipal Budget): 財政規模
- **地域ブランド施策** (Regional Branding Initiative): ブランディング活動
- **ICT推進度** (ICT Promotion Level): デジタル化の進展
- **起業支援プログラム数** (Startup Support Programs): 起業環境
- **観光プロモーション費** (Tourism Promotion Budget): 観光投資
- **交通アクセス指数** (Transportation Access Index): アクセシビリティ
- **大学・研究機関数** (Universities/Research Institutions): 知的資源

### 3. 分析手法 / Analysis Methods

- **記述統計**: 各指標の基本統計量
- **相関分析**: 指標間の関連性
- **主成分分析 (PCA)**: 指標の次元削減
- **重回帰分析**: 因子の影響度推定
- **ランダムフォレスト**: 変数重要度分析
- **ロジスティック回帰**: 成功要因の特定

## 出力結果 / Output

### データファイル / Data Files

- `R/data/outcome_indicators.csv`: アウトカム指標データ
- `R/data/regional_factors.csv`: 地域因子データ
- `R/data/classified_regions.csv`: 成功レベル分類済みデータ
- `R/output/factor_importance_ranking.csv`: 因子重要度ランキング

### 可視化図表 / Visualizations

- `outcome_correlation_plot.png`: アウトカム指標の相関マトリクス
- `outcome_pca_biplot.png`: PCAバイプロット
- `rf_importance_*.png`: ランダムフォレストによる変数重要度
- `outcome_distributions.png`: アウトカム指標の分布
- `success_level_comparison.png`: 成功レベル別比較
- `factor_importance_ranking.png`: 因子影響度ランキング
- `factor_outcome_relationships.png`: 因子とアウトカムの関係

## 今後の拡張 / Future Enhancements

- [ ] 実際の統計データ（e-Stat等）との連携
- [ ] 時系列分析の追加
- [ ] 地理空間分析の統合
- [ ] インタラクティブなダッシュボードの作成
- [ ] 機械学習モデルの追加（XGBoost、LightGBM等）

## ライセンス / License

このプロジェクトは MIT ライセンスの下で公開されています。詳細は [LICENSE](LICENSE) ファイルを参照してください。

## 注意事項 / Notes

現在のバージョンでは、サンプルデータを使用した分析のデモンストレーションです。実際の研究には、信頼できる統計データソースからのデータ取得が必要です。
=======
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
