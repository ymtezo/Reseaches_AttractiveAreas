# 実データ取得クイックスタート
# Real Data Fetching Quick Start

このドキュメントでは、実際の日本政府統計データを取得して分析を始めるための最速の方法を説明します。

## 🚀 5分で始める

### ステップ1: e-Stat APIキーの取得（5分）

1. **e-Statにアクセス**: https://www.e-stat.go.jp/
2. **新規登録**: 右上の「新規登録」からアカウントを作成
3. **ログイン**: 登録したメールアドレスとパスワードでログイン
4. **API機能へアクセス**: https://www.e-stat.go.jp/api/
5. **アプリケーションID取得**: 「アプリケーションID発行」から新規発行
   - 名称: 任意（例: 地域創生研究）
   - URL: 任意（例: https://github.com/your_username/your_repo）
6. **APIキーをコピー**: 発行されたアプリケーションIDをメモ

### ステップ2: APIキーの設定

#### 方法A: R内で一時的に設定（簡単）

```r
# RまたはRStudioで以下を実行
Sys.setenv(ESTAT_API_KEY = "あなたのアプリケーションID")
```

#### 方法B: .Renvironファイルで永続的に設定（推奨）

1. ホームディレクトリの .Renviron ファイルを開く（なければ作成）

   ```r
   # Rコンソールで実行
   file.edit("~/.Renviron")
   ```

2. 以下の行を追加して保存

   ```
   ESTAT_API_KEY=あなたのアプリケーションID
   ```

3. Rを再起動

### ステップ3: 必要なパッケージのインストール

```r
# 必要なパッケージを一括インストール
install.packages(c("tidyverse", "estatapi", "httr", "jsonlite", "here"))
```

### ステップ4: データ取得スクリプトの実行

```r
# 作業ディレクトリをプロジェクトルートに設定
setwd("/path/to/Reseaches_AttractiveAreas")

# データ取得スクリプトを実行
source("R/scripts/00_fetch_real_data.R")

# メイン関数を実行
main()
```

## 📊 取得できるデータ

### 人口データ
- 住民基本台帳人口移動報告
- 都道府県・市区町村別の人口、転入転出データ

### 経済データ
- 経済センサス（事業所数、従業者数）
- 県民経済計算（GDP、経済成長率）

### 労働データ
- 労働力調査（就業者数、失業率）
- 賃金構造基本統計調査（平均所得）

### その他
- 観光データ（観光客数、宿泊施設稼働率）
- 教育データ（学校数、進学率）
- 医療データ（病院数、医師数）

## 💡 使用例

### 例1: 人口データの検索と取得

```r
# スクリプトを読み込む
source("R/scripts/00_fetch_real_data.R")

# 「人口」に関する統計表を検索
stats_list <- search_estat_tables("人口")

# 検索結果の確認
View(stats_list)

# 統計表IDを指定してデータ取得
population_data <- fetch_estat_data(stats_list$`@id`[1])

# データの確認
head(population_data)
summary(population_data)

# CSVファイルとして保存
write_csv(population_data, "R/data/real_data/population.csv")
```

### 例2: 経済センサスデータの取得

```r
source("R/scripts/00_fetch_real_data.R")

# 経済センサスデータの取得
establishment_data <- fetch_establishment_data()

# データの保存
write_csv(establishment_data, "R/data/real_data/establishments.csv")
```

### 例3: 複数のデータを一度に取得

```r
source("R/scripts/00_fetch_real_data.R")

# 人口データ
population <- fetch_population_data()
write_csv(population, "R/data/real_data/population.csv")

# 労働データ
labor <- fetch_labor_data()
write_csv(labor, "R/data/real_data/labor.csv")

cat("すべてのデータ取得が完了しました！\n")
```

## 🔍 データの確認と整形

### 取得したデータの確認

```r
library(tidyverse)

# データの読み込み
data <- read_csv("R/data/real_data/population.csv")

# データ構造の確認
glimpse(data)

# 基本統計量
summary(data)

# 列名の確認
colnames(data)

# 最初の数行を表示
head(data)
```

### データの整形例

```r
# 必要な列だけを抽出
cleaned_data <- data %>%
  select(地域コード, 地域名, 人口総数, 人口増減率) %>%
  # 欠損値を除外
  na.omit() %>%
  # 地域コードでソート
  arrange(地域コード)

# 整形したデータを保存
write_csv(cleaned_data, "R/data/real_data/population_cleaned.csv")
```

## 🗺️ 市区町村コードと都道府県コード

### 都道府県コード（JIS X 0401）

| コード | 都道府県 | コード | 都道府県 |
|--------|----------|--------|----------|
| 01 | 北海道 | 25 | 滋賀県 |
| 02 | 青森県 | 26 | 京都府 |
| 03 | 岩手県 | 27 | 大阪府 |
| 04 | 宮城県 | 28 | 兵庫県 |
| 05 | 秋田県 | 29 | 奈良県 |
| 06 | 山形県 | 30 | 和歌山県 |
| 07 | 福島県 | 31 | 鳥取県 |
| 08 | 茨城県 | 32 | 島根県 |
| 09 | 栃木県 | 33 | 岡山県 |
| 10 | 群馬県 | 34 | 広島県 |
| 11 | 埼玉県 | 35 | 山口県 |
| 12 | 千葉県 | 36 | 徳島県 |
| 13 | 東京都 | 37 | 香川県 |
| 14 | 神奈川県 | 38 | 愛媛県 |
| 15 | 新潟県 | 39 | 高知県 |
| 16 | 富山県 | 40 | 福岡県 |
| 17 | 石川県 | 41 | 佐賀県 |
| 18 | 福井県 | 42 | 長崎県 |
| 19 | 山梨県 | 43 | 熊本県 |
| 20 | 長野県 | 44 | 大分県 |
| 21 | 岐阜県 | 45 | 宮崎県 |
| 22 | 静岡県 | 46 | 鹿児島県 |
| 23 | 愛知県 | 47 | 沖縄県 |
| 24 | 三重県 | | |

### 市区町村コードの確認方法

```r
# e-Statで市区町村コードを検索
# 例: 東京都千代田区 = 13101
# 例: 大阪市 = 27100

# または、総務省の全国地方公共団体コードを参照
# https://www.soumu.go.jp/denshijiti/code.html
```

## ⚠️ よくある問題と解決方法

### エラー: "APIキーが設定されていません"

**解決方法:**
```r
# APIキーを設定
Sys.setenv(ESTAT_API_KEY = "your_app_id_here")

# 設定を確認
Sys.getenv("ESTAT_API_KEY")
```

### エラー: "統計表が見つかりませんでした"

**原因:** 検索キーワードが適切でない、または該当する統計がない

**解決方法:**
```r
# より一般的なキーワードで検索
stats_list <- search_estat_tables("人口")  # ✓ 良い例
# stats_list <- search_estat_tables("特定の市町村の人口")  # ✗ 具体的すぎる

# e-Statのウェブサイトで事前に統計表を確認
# https://www.e-stat.go.jp/
```

### エラー: パッケージが見つからない

**解決方法:**
```r
# パッケージを個別にインストール
install.packages("estatapi")
install.packages("tidyverse")
```

### データが大きすぎてメモリエラー

**解決方法:**
```r
# データを分割して取得
# 1. 都道府県別に取得
# 2. 年次別に取得
# 3. 必要な列だけを選択

# または、データベースに保存
library(RSQLite)
con <- dbConnect(SQLite(), "regional_data.db")
dbWriteTable(con, "population", population_data)
```

## 📚 次のステップ

1. **データの整形**: 取得したデータを分析用に整形
   ```r
   source("R/scripts/01_data_collection.R")
   ```

2. **データの探索**: アウトカム指標を探索
   ```r
   source("R/scripts/02_outcome_exploration.R")
   ```

3. **因子分析**: 成功因子を分析
   ```r
   source("R/scripts/03_factor_analysis.R")
   ```

4. **可視化**: 結果を可視化
   ```r
   source("R/scripts/04_visualization.R")
   ```

## 📖 詳細ドキュメント

より詳しい情報は以下を参照してください：

- **[日本の統計データソースガイド](JAPAN_STATISTICAL_DATA_SOURCES.md)**: 全データソースの詳細
- **[変数定義ガイド](VARIABLES_README.md)**: 使用する変数の詳細
- **[データ構造仕様](R/DATA_STRUCTURE.md)**: データの構造と形式

## 🆘 サポート

問題が解決しない場合：

1. **e-Stat APIヘルプ**: https://www.e-stat.go.jp/api/api-info/api-guide
2. **estatapi パッケージのGitHub**: https://github.com/yutannihilation/estatapi
3. **Issue報告**: このリポジトリのIssuesセクション

---

**最終更新**: 2026-03-10
