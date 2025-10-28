# クイックリファレンス
# Quick Reference Guide

## 1分で始める / Quick Start (1 minute)

```r
# 1. Rを起動
# 2. 以下を実行
source("R/main_analysis.R")
# 3. R/output/ ディレクトリで結果を確認
```

## よく使うコマンド / Common Commands

### すべての分析を実行
```r
source("R/main_analysis.R")
```

### 個別スクリプトの実行
```r
# データ生成のみ
source("R/scripts/01_data_collection.R")

# アウトカム探索のみ
source("R/scripts/02_outcome_exploration.R")

# 因子分析のみ
source("R/scripts/03_factor_analysis.R")

# 可視化のみ
source("R/scripts/04_visualization.R")
```

### データの読み込みと確認
```r
library(tidyverse)

# アウトカムデータの読み込み
outcome <- read_csv("R/data/outcome_indicators.csv")
head(outcome)
summary(outcome)

# 因子データの読み込み
factors <- read_csv("R/data/regional_factors.csv")
head(factors)

# 分類済みデータの読み込み
classified <- read_csv("R/data/classified_regions.csv")
table(classified$success_level)
```

## 主要な分析結果の見方 / How to Interpret Results

### 1. 記述統計（コンソール出力）
- 各指標の平均値、標準偏差、範囲などを確認
- 外れ値や異常値をチェック

### 2. 相関分析
- **ファイル**: `R/output/outcome_correlation_plot.png`
- **見方**: 色が濃いほど相関が強い（赤=正の相関、青=負の相関）
- **活用**: 互いに強く相関する指標を特定

### 3. 主成分分析（PCA）
- **ファイル**: `R/output/outcome_pca_biplot.png`
- **見方**: 
  - 矢印が長いほど、その指標の寄与が大きい
  - 矢印の方向が近いほど、指標間の相関が高い
- **活用**: アウトカム指標の次元削減と解釈

### 4. 因子重要度
- **ファイル**: 
  - `R/output/factor_importance_ranking.csv`
  - `R/output/factor_importance_ranking.png`
- **見方**: 値が大きいほど、その因子の影響力が強い
- **活用**: 優先的に取り組むべき施策の特定

### 5. 成功レベル別比較
- **ファイル**: `R/output/success_level_comparison.png`
- **見方**: 成功地域と課題地域の指標値の差を確認
- **活用**: 成功の特徴を理解

### 6. 因子とアウトカムの関係
- **ファイル**: `R/output/factor_outcome_relationships.png`
- **見方**: 
  - 散布図の傾き: 因子とアウトカムの関係の強さと方向
  - 点の色: 成功レベル別の分布
- **活用**: 具体的な因子の効果を視覚的に確認

## カスタマイズ / Customization

### サンプルサイズの変更
```r
# R/scripts/01_data_collection.R の該当行を編集
# 例: 100地域 → 200地域
outcome_data <- generate_sample_outcome_data(n_regions = 200)
factor_data <- generate_sample_factor_data(n_regions = 200)
```

### 分析対象アウトカムの変更
```r
# R/scripts/03_factor_analysis.R の該当行を編集
outcome_vars <- c("population_change_rate", "youth_ratio", "employment_rate", "immigrants")
```

### 成功レベルの閾値変更
```r
# R/scripts/02_outcome_exploration.R の classify_regions() 関数内を編集
success_level = case_when(
  success_index >= quantile(success_index, 0.80) ~ "高成功",  # 上位20%
  success_index >= quantile(success_index, 0.40) ~ "中程度",  # 40-80%
  TRUE ~ "課題"  # 下位40%
)
```

## トラブルシューティング / Troubleshooting

### エラー: パッケージが見つからない
```r
install.packages("パッケージ名")
```

### エラー: ファイルが見つからない
```r
# 作業ディレクトリの確認
getwd()

# プロジェクトルートに移動
setwd("/path/to/Reseaches_AttractiveAreas")
```

### エラー: データファイルがない
```r
# データ生成スクリプトを先に実行
source("R/scripts/01_data_collection.R")
```

### 日本語が文字化けする
```r
# Windows
par(family = "MS Gothic")

# macOS
par(family = "Hiragino Sans")
```

### メモリ不足
```r
# メモリ制限を増やす（Windows）
memory.limit(size = 8000)

# サンプルサイズを減らす
# 01_data_collection.R で n_regions を小さくする
```

## 結果の保存 / Saving Results

### CSVファイルのエクスポート
```r
# 重要度ランキングを別名で保存
ranking <- read_csv("R/output/factor_importance_ranking.csv")
write_csv(ranking, "my_analysis_results.csv")
```

### 図表の保存形式変更
```r
# PNG → PDF
ggsave("plot.pdf", plot_object, width = 10, height = 8)

# PNG → JPEG
ggsave("plot.jpg", plot_object, width = 10, height = 8)
```

## 次のステップ / Next Steps

1. **実データの統合**: e-Stat等から実データを取得
2. **時系列分析**: 複数年のデータで経年変化を分析
3. **予測モデル**: 将来のアウトカムを予測
4. **地図表示**: 地理情報と統合して地図上に可視化

## ヘルプ / Help

詳細は以下のドキュメントを参照：

- [README.md](../README.md) - プロジェクト概要
- [SETUP.md](SETUP.md) - セットアップガイド
- [DATA_STRUCTURE.md](DATA_STRUCTURE.md) - データ構造仕様
