# セットアップガイド
# Setup Guide

## R環境のセットアップ

### Windows

1. **R本体のインストール**
   - [CRAN](https://cran.r-project.org/bin/windows/base/) から最新版をダウンロード
   - インストーラーを実行してインストール

2. **RStudio のインストール（推奨）**
   - [RStudio Desktop](https://www.rstudio.com/products/rstudio/download/) をダウンロード
   - インストーラーを実行してインストール

3. **Rtoolsのインストール（必要に応じて）**
   - 一部のパッケージのコンパイルに必要
   - [Rtools](https://cran.r-project.org/bin/windows/Rtools/) からダウンロード

### macOS

1. **R本体のインストール**
   - [CRAN](https://cran.r-project.org/bin/macosx/) から最新版をダウンロード
   - .pkgファイルを開いてインストール

2. **RStudio のインストール（推奨）**
   - [RStudio Desktop](https://www.rstudio.com/products/rstudio/download/) をダウンロード
   - .dmgファイルを開いてインストール

3. **Xcode Command Line Tools（必要に応じて）**
   ```bash
   xcode-select --install
   ```

### Linux (Ubuntu/Debian)

1. **R本体のインストール**
   ```bash
   sudo apt update
   sudo apt install r-base r-base-dev
   ```

2. **RStudio のインストール（推奨）**
   ```bash
   # 最新版のURLを https://www.rstudio.com/products/rstudio/download/ で確認
   wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-2023.XX.X-XXX-amd64.deb
   sudo dpkg -i rstudio-*.deb
   sudo apt-get install -f  # 依存関係の解決
   ```

3. **依存ライブラリのインストール**
   ```bash
   sudo apt install libcurl4-openssl-dev libssl-dev libxml2-dev
   ```

## プロジェクトのセットアップ

### 1. リポジトリのクローン

```bash
git clone https://github.com/ymtezo/Reseaches_AttractiveAreas.git
cd Reseaches_AttractiveAreas
```

### 2. Rパッケージのインストール

#### 方法A: 自動インストール（推奨）

メインスクリプトを実行すると、必要なパッケージが自動的にインストールされます：

```r
Rscript R/main_analysis.R
```

#### 方法B: 手動インストール

R または RStudio で以下を実行：

```r
# 必要なパッケージのリスト
packages <- c(
  "tidyverse",    # データ処理・可視化
  "here",         # パス管理
  "corrplot",     # 相関プロット
  "psych",        # 心理統計
  "FactoMineR",   # 因子分析・PCA
  "randomForest", # ランダムフォレスト
  "caret",        # 機械学習フレームワーク
  "MASS",         # 統計関数
  "pROC",         # ROC分析
  "ggplot2",      # グラフ作成
  "patchwork",    # 複数グラフの結合
  "scales",       # スケール変換
  "lm.beta"       # 標準化回帰係数
)

# パッケージのインストール
install.packages(packages)
```

## 実行方法

### コマンドラインから実行

```bash
cd Reseaches_AttractiveAreas
Rscript R/main_analysis.R
```

### RStudio で実行

1. RStudio を起動
2. `File > Open Project` から `Reseaches_AttractiveAreas.Rproj` を開く（なければプロジェクトを作成）
3. `R/main_analysis.R` を開く
4. `Source` ボタンをクリック、または `Ctrl+Shift+S` (Windows/Linux) / `Cmd+Shift+S` (Mac)

### R コンソールから実行

```r
# 作業ディレクトリを設定
setwd("/path/to/Reseaches_AttractiveAreas")

# メインスクリプトを実行
source("R/main_analysis.R")
```

## トラブルシューティング

### パッケージのインストールエラー

**エラー**: パッケージ XXX が見つからない

**解決策**:
```r
# CRANミラーを明示的に指定
install.packages("パッケージ名", repos = "https://cran.r-project.org")

# または異なるミラーを試す
chooseCRANmirror()
install.packages("パッケージ名")
```

### 依存関係エラー（Linux）

**エラー**: コンパイル時に libXXX が見つからない

**解決策**:
```bash
# Ubuntu/Debian
sudo apt install libcurl4-openssl-dev libssl-dev libxml2-dev libfontconfig1-dev libharfbuzz-dev libfribidi-dev

# CentOS/RHEL
sudo yum install openssl-devel libcurl-devel libxml2-devel
```

### メモリ不足エラー

**エラー**: メモリ不足で処理が中断される

**解決策**:
```r
# メモリ制限を増やす
memory.limit(size = 8000)  # Windows のみ

# 大きなデータセットを扱う場合は、サンプルサイズを減らす
# 01_data_collection.R の n_regions パラメータを調整
```

### 日本語文字化け

**エラー**: グラフや出力に日本語が正しく表示されない

**解決策**:
```r
# Windows
par(family = "MS Gothic")

# macOS
par(family = "Hiragino Sans")

# Linux (日本語フォントをインストール後)
par(family = "TakaoPGothic")
```

## 環境確認

インストールが正しく完了したか確認：

```r
# Rのバージョン確認
R.version.string

# パッケージのロード確認
library(tidyverse)
library(randomForest)

# セッション情報の表示
sessionInfo()
```

## 次のステップ

セットアップが完了したら：

1. [README.md](../README.md) で プロジェクトの概要を確認
2. [DATA_STRUCTURE.md](DATA_STRUCTURE.md) でデータ構造を理解
3. `R/main_analysis.R` を実行して分析を開始
4. `R/output/` ディレクトリで結果を確認
