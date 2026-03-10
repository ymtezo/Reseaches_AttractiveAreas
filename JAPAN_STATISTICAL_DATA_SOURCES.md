# 日本の統計データソースガイド
# Japanese Statistical Data Sources Guide

本ドキュメントでは、地域創生研究に使用できる日本国の公的統計データソースについて詳しく説明します。

## 目次

1. [政府統計の総合窓口（e-Stat）](#1-政府統計の総合窓口e-stat)
2. [省庁別統計データ](#2-省庁別統計データ)
3. [研究機関・シンクタンク](#3-研究機関シンクタンク)
4. [地方自治体のオープンデータ](#4-地方自治体のオープンデータ)
5. [API・データ取得方法](#5-apiデータ取得方法)
6. [変数とデータソースの対応表](#6-変数とデータソースの対応表)

---

## 1. 政府統計の総合窓口（e-Stat）

### 概要
e-Statは日本の政府統計のポータルサイトで、各府省等が実施する統計調査の結果を一元的に提供しています。

### 基本情報
- **URL**: https://www.e-stat.go.jp/
- **運営**: 総務省統計局
- **特徴**:
  - 650以上の統計データを横断検索可能
  - CSV、Excel、API形式でデータ取得可能
  - 無料で利用可能（一部データは申請が必要）

### 主要な統計データ

#### 人口・世帯
- **国勢調査** (5年ごと)
  - 人口総数、年齢別人口、世帯数、産業別就業者数など
  - URL: https://www.e-stat.go.jp/stat-search/files?page=1&toukei=00200521

- **住民基本台帳人口移動報告**（月次・年次）
  - 都道府県間・市区町村間の人口移動
  - URL: https://www.e-stat.go.jp/stat-search/files?page=1&toukei=00200523

- **人口推計**（月次）
  - 最新の人口動態データ
  - URL: https://www.e-stat.go.jp/stat-search/files?page=1&toukei=00200524

#### 経済・産業
- **経済センサス**（5年ごと）
  - 事業所数、従業者数、売上高など
  - URL: https://www.e-stat.go.jp/stat-search/files?page=1&toukei=00200553

- **工業統計調査**（年次）
  - 製造業の事業所数、従業者数、製造品出荷額など
  - URL: https://www.e-stat.go.jp/stat-search/files?page=1&toukei=00550002

- **商業統計調査**（5年ごと）
  - 商業の事業所数、従業者数、年間商品販売額など
  - URL: https://www.e-stat.go.jp/stat-search/files?page=1&toukei=00550010

#### 労働
- **労働力調査**（月次・年次）
  - 就業者数、完全失業率、有効求人倍率など
  - URL: https://www.e-stat.go.jp/stat-search/files?page=1&toukei=00200531

- **賃金構造基本統計調査**（年次）
  - 産業別・職種別・都道府県別の賃金データ
  - URL: https://www.e-stat.go.jp/stat-search/files?page=1&toukei=00450091

#### 家計・消費
- **家計調査**（月次・年次）
  - 家計収支、消費支出、貯蓄・負債など
  - URL: https://www.e-stat.go.jp/stat-search/files?page=1&toukei=00200561

### API利用方法
e-StatはREST APIを提供しており、プログラムから直接データ取得が可能です。

- **API仕様書**: https://www.e-stat.go.jp/api/
- **利用登録**: https://www.e-stat.go.jp/api/api-info/api-guide （無料、アプリケーションIDの取得が必要）

**Rでの利用例**:
```r
# estatapi パッケージを使用
install.packages("estatapi")
library(estatapi)

# アプリケーションIDを設定
Sys.setenv(ESTAT_API_KEY = "your_app_id_here")

# 統計表情報の取得
stats <- estat_getStatsList(appId = Sys.getenv("ESTAT_API_KEY"),
                            searchWord = "人口")

# データの取得
data <- estat_getStatsData(appId = Sys.getenv("ESTAT_API_KEY"),
                           statsDataId = "0000010101")
```

---

## 2. 省庁別統計データ

### 2.1 内閣府

#### 県民経済計算
- **内容**: 都道府県別の経済活動を生産・分配・支出の3面から把握
- **URL**: https://www.esri.cao.go.jp/jp/sna/data/data_list/kenmin/files/files_kenmin.html
- **データ項目**:
  - 県内総生産（GDP）
  - 一人当たり県民所得
  - 経済成長率
  - 産業別県内総生産

#### 地域経済分析システム（RESAS）
- **内容**: 地域経済に関する官民ビッグデータを可視化
- **URL**: https://resas.go.jp/
- **データ項目**:
  - 人口動態
  - 地域経済循環
  - 企業活動
  - 観光
  - まちづくり
- **API**: https://opendata.resas-portal.go.jp/ （要登録）

#### 景気ウォッチャー調査
- **内容**: 地域の景気動向を示す景況感データ
- **URL**: https://www5.cao.go.jp/keizai3/watcher/watcher_menu.html

### 2.2 総務省

#### 住民基本台帳に基づく人口、人口動態及び世帯数
- **内容**: 都道府県・市区町村別の人口、転入転出、出生死亡データ
- **URL**: https://www.soumu.go.jp/main_sosiki/jichi_gyousei/daityo/jinkou.html

#### 地方財政状況調査（決算統計）
- **内容**: 地方自治体の歳入歳出、財政指標
- **URL**: https://www.soumu.go.jp/iken/zaisei/ichiran01_2023.html
- **データ項目**:
  - 財政力指数
  - 実質公債費比率
  - 歳入・歳出決算額

#### 情報通信白書統計データ
- **内容**: ICT・通信インフラの普及状況
- **URL**: https://www.soumu.go.jp/johotsusintokei/

### 2.3 厚生労働省

#### 人口動態調査
- **内容**: 出生、死亡、婚姻、離婚の人口動態統計
- **URL**: https://www.mhlw.go.jp/toukei/list/81-1.html
- **データ項目**:
  - 合計特殊出生率
  - 年齢別出生率
  - 平均寿命

#### 市区町村別生命表
- **内容**: 市区町村別の平均余命
- **URL**: https://www.mhlw.go.jp/toukei/saikin/hw/life/ckts20/index.html

#### 医療施設調査
- **内容**: 病院・診療所の数、病床数
- **URL**: https://www.mhlw.go.jp/toukei/list/79-1.html

### 2.4 文部科学省

#### 学校基本調査
- **内容**: 学校数、在学者数、教職員数、進学率など
- **URL**: https://www.mext.go.jp/b_menu/toukei/chousa01/kihon/1267995.htm
- **データ項目**:
  - 大学進学率
  - 学校種別の施設数
  - 生徒数・学生数

#### 学校保健統計調査
- **内容**: 児童・生徒の発育状況、健康状態
- **URL**: https://www.mext.go.jp/b_menu/toukei/chousa05/hoken/1268826.htm

### 2.5 農林水産省

#### 農林業センサス
- **内容**: 農林業の基本構造、経営体数
- **URL**: https://www.maff.go.jp/j/tokei/census/afc/

#### 市町村別農業産出額（推計）
- **内容**: 市町村別の農業産出額
- **URL**: https://www.maff.go.jp/j/tokei/kouhyou/sityoson_sansyutu/

### 2.6 経済産業省

#### 工業統計調査
- **内容**: 製造業の事業所数、従業者数、製造品出荷額
- **URL**: https://www.meti.go.jp/statistics/tyo/kougyo/

#### 商業動態統計調査
- **内容**: 商業の販売額動向
- **URL**: https://www.meti.go.jp/statistics/tyo/syoudou/

### 2.7 国土交通省

#### 国土数値情報
- **内容**: 国土に関する地理空間情報（GISデータ）
- **URL**: https://nlftp.mlit.go.jp/ksj/
- **データ項目**:
  - 行政区域
  - 鉄道・駅
  - バス停留所
  - 医療機関
  - 学校
  - 公共施設

#### 地価公示
- **内容**: 全国の標準地の地価
- **URL**: https://www.mlit.go.jp/totikensangyo/totikensangyo_fr4_000043.html

#### 都道府県地価調査
- **内容**: 都道府県が実施する地価調査
- **URL**: https://www.mlit.go.jp/totikensangyo/totikensangyo_fr4_000044.html

#### 建築着工統計調査
- **内容**: 新設住宅着工戸数
- **URL**: https://www.mlit.go.jp/statistics/details/jutaku_list.html

### 2.8 観光庁

#### 宿泊旅行統計調査
- **内容**: 都道府県・観光地域別の宿泊者数、稼働率
- **URL**: https://www.mlit.go.jp/kankocho/siryou/toukei/shukuhakutoukei.html

#### 訪日外国人消費動向調査
- **内容**: 訪日外国人の旅行消費額
- **URL**: https://www.mlit.go.jp/kankocho/siryou/toukei/syouhityousa.html

### 2.9 警察庁

#### 犯罪統計
- **内容**: 都道府県別・罪種別の犯罪認知件数
- **URL**: https://www.npa.go.jp/publications/statistics/crime/

#### 交通事故統計
- **内容**: 交通事故発生件数、死傷者数
- **URL**: https://www.npa.go.jp/publications/statistics/koutsuu/index.html

---

## 3. 研究機関・シンクタンク

### 3.1 国立社会保障・人口問題研究所

#### 日本の地域別将来推計人口
- **内容**: 都道府県・市区町村別の将来人口推計
- **URL**: https://www.ipss.go.jp/pp-shicyoson/j/shicyoson18/t-page.asp

#### 人口移動調査
- **内容**: 都道府県間の人口移動
- **URL**: https://www.ipss.go.jp/syoushika/tohkei/Popular/Popular.asp

### 3.2 日本総合研究所

#### 地域経済レポート
- **内容**: 地域経済の動向分析
- **URL**: https://www.jri.co.jp/research/region/

### 3.3 みずほリサーチ&テクノロジーズ

#### 地域経済レポート
- **内容**: 地域経済の構造分析
- **URL**: https://www.mizuho-rt.co.jp/publication/mhrt/research/index.html

### 3.4 大和総研

#### 地域・中小企業レポート
- **内容**: 地域経済、中小企業動向
- **URL**: https://www.dir.co.jp/report/research/

---

## 4. 地方自治体のオープンデータ

### 4.1 主要自治体のオープンデータポータル

#### 東京都オープンデータカタログサイト
- **URL**: https://portal.data.metro.tokyo.lg.jp/

#### 横浜市オープンデータポータル
- **URL**: https://data.city.yokohama.lg.jp/

#### 大阪市オープンデータポータルサイト
- **URL**: https://www.city.osaka.lg.jp/shisei_top/category/3042-2-0-0-0.html

#### 名古屋市オープンデータ
- **URL**: https://www.city.nagoya.jp/shicho/page/0000080730.html

#### 福岡市オープンデータサイト
- **URL**: https://www.open-governmentdata.org/fukuoka-city/

#### 札幌市オープンデータ
- **URL**: https://ckan.pf-sapporo.jp/

### 4.2 データカタログサイト

#### DATA.GO.JP（政府のデータカタログサイト）
- **URL**: https://www.data.go.jp/
- **内容**: 国・地方自治体のオープンデータを横断検索

### 4.3 自治体データの主な内容
- 人口統計
- 財政データ
- 公共施設情報
- イベント情報
- 交通情報
- 環境データ（大気、水質）
- 地域経済指標

---

## 5. API・データ取得方法

### 5.1 e-Stat API（推奨）

#### 利用準備
1. e-Statサイトでアカウント登録
2. アプリケーションIDの取得: https://www.e-stat.go.jp/api/
3. APIの仕様書を確認

#### Rパッケージの利用
```r
# estatapi パッケージのインストール
install.packages("estatapi")
library(estatapi)

# アプリケーションIDの設定
Sys.setenv(ESTAT_API_KEY = "your_app_id")

# 統計表リストの取得
stats_list <- estat_getStatsList(
  appId = Sys.getenv("ESTAT_API_KEY"),
  searchWord = "人口",
  surveyYears = "202300"  # 2023年のデータ
)

# 統計データの取得
population_data <- estat_getStatsData(
  appId = Sys.getenv("ESTAT_API_KEY"),
  statsDataId = "0003410379"  # 統計表ID
)

# データの保存
write_csv(population_data, "R/data/population_data.csv")
```

### 5.2 RESAS API

#### 利用準備
1. RESASサイトでAPI利用登録: https://opendata.resas-portal.go.jp/
2. APIキーの取得
3. API仕様書の確認

#### Rでの利用例
```r
library(httr)
library(jsonlite)

# APIキーの設定
api_key <- "your_resas_api_key"

# 人口構成データの取得例
response <- GET(
  "https://opendata.resas-portal.go.jp/api/v1/population/composition/perYear",
  query = list(
    prefCode = "13",    # 東京都
    cityCode = "13101"  # 千代田区
  ),
  add_headers(`X-API-KEY` = api_key)
)

# JSONデータの解析
data <- fromJSON(content(response, "text", encoding = "UTF-8"))
```

### 5.3 国土数値情報のダウンロード

```r
# kokudosuuchi パッケージの利用
install.packages("kokudosuuchi")
library(kokudosuuchi)

# 行政区域データの取得
admin_areas <- getKSJData(
  identifier = "N03",  # 行政区域
  prefCode = 13        # 東京都
)

# 鉄道データの取得
railways <- getKSJData(
  identifier = "N02",  # 鉄道
  prefCode = 13
)
```

### 5.4 データ取得のベストプラクティス

1. **API利用時の注意点**
   - APIキーは環境変数に保存（GitHubにコミットしない）
   - リクエスト回数制限を確認
   - エラーハンドリングを実装

2. **データキャッシュ**
   - 取得したデータはローカルに保存
   - 更新頻度に応じて再取得

3. **データの前処理**
   - 文字コードの確認（UTF-8への変換）
   - 欠損値の処理
   - データ型の変換

---

## 6. 変数とデータソースの対応表

本リポジトリの`variables_definition.R`で定義されている変数と、実際のデータソースの対応関係を示します。

### 6.1 アウトカム変数のデータソース

#### 政府統計・公的機関データ

| 変数名（日本語） | 変数名（英語） | データソース | 具体的な統計 |
|------------------|----------------|--------------|--------------|
| 地域内総生産（GDP） | Regional GDP | 内閣府 | 県民経済計算 |
| 一人当たりGDP | GDP per capita | 内閣府 | 県民経済計算 |
| 経済成長率 | Economic growth rate | 内閣府 | 県民経済計算 |
| 人口増減率 | Population change rate | 総務省 | 住民基本台帳人口移動報告 |
| 社会増減率 | Net migration rate | 総務省 | 住民基本台帳人口移動報告 |
| 自然増減率 | Natural increase rate | 厚生労働省 | 人口動態統計 |
| 合計特殊出生率 | Total fertility rate | 厚生労働省 | 人口動態統計 |
| 平均所得 | Average income | 厚生労働省 | 賃金構造基本統計調査 |
| 有効求人倍率 | Job opening to applicant ratio | 厚生労働省 | 職業安定業務統計 |
| 完全失業率 | Unemployment rate | 総務省 | 労働力調査 |
| 財政力指数 | Financial capability index | 総務省 | 地方財政状況調査 |
| 実質公債費比率 | Real debt service ratio | 総務省 | 地方財政状況調査 |
| 大学進学率 | University enrollment rate | 文部科学省 | 学校基本調査 |
| 学力水準 | Academic achievement level | 文部科学省 | 全国学力・学習状況調査 |
| 平均寿命 | Life expectancy | 厚生労働省 | 市区町村別生命表 |
| 健康寿命 | Healthy life expectancy | 厚生労働省 | 健康寿命の算定プログラム |
| 一人当たり医療費 | Medical expense per capita | 厚生労働省 | 医療費の地域差分析 |
| 犯罪認知件数（人口千人当たり） | Crime rate per 1000 people | 警察庁 | 犯罪統計資料 |
| 交通事故発生率 | Traffic accident rate | 警察庁 | 交通事故統計 |

#### 家計調査データ

| 変数名（日本語） | 変数名（英語） | データソース | 具体的な統計 |
|------------------|----------------|--------------|--------------|
| 趣味娯楽費割合 | Entertainment expense ratio | 総務省 | 家計調査 |
| 教育費割合 | Education expense ratio | 総務省 | 家計調査 |
| 外食費割合 | Eating-out expense ratio | 総務省 | 家計調査 |
| 貯蓄率 | Savings rate | 総務省 | 家計調査 |
| 消費支出総額 | Total consumption expenditure | 総務省 | 家計調査 |

#### 民間企業・研究機関データ

| 変数名（日本語） | 変数名（英語） | データソース | 具体的な統計 |
|------------------|----------------|--------------|--------------|
| 地価上昇率 | Land price growth rate | 国土交通省 | 地価公示 |
| 小売販売額 | Retail sales | 経済産業省 | 商業動態統計 |
| 観光客数 | Number of tourists | 観光庁 | 宿泊旅行統計調査 |
| 宿泊施設稼働率 | Accommodation occupancy rate | 観光庁 | 宿泊旅行統計調査 |
| 新規事業所開設率 | New business establishment rate | 総務省・経済産業省 | 経済センサス |
| 企業誘致数 | Number of attracted companies | 地方自治体 | 各自治体の公表データ |

#### 環境・インフラ指標

| 変数名（日本語） | 変数名（英語） | データソース | 具体的な統計 |
|------------------|----------------|--------------|--------------|
| 一人当たりCO2排出量 | CO2 emissions per capita | 環境省 | 地方公共団体実行計画 |
| 再生可能エネルギー導入率 | Renewable energy adoption rate | 経済産業省 | エネルギー生産・需給統計 |
| 一人当たり公園面積 | Park area per capita | 国土交通省 | 都市公園等整備現況調査 |
| 水道普及率 | Water supply coverage rate | 厚生労働省 | 水道統計 |
| 下水道普及率 | Sewerage coverage rate | 国土交通省 | 下水道統計 |

#### デジタル・通信

| 変数名（日本語） | 変数名（英語） | データソース | 具体的な統計 |
|------------------|----------------|--------------|--------------|
| ブロードバンド普及率 | Broadband penetration rate | 総務省 | 通信利用動向調査 |
| ICT利活用度 | ICT utilization level | 総務省 | 情報通信白書 |
| 電子自治体成熟度 | E-government maturity level | 総務省 | 自治体DX推進状況調査 |

### 6.2 地域特性変数のデータソース

#### 地理・位置

| 変数名（日本語） | 変数名（英語） | データソース |
|------------------|----------------|--------------|
| 都道府県コード | Prefecture code | 総務省（JIS X 0401） |
| 市区町村コード | Municipality code | 総務省（JIS X 0402） |
| 面積 | Area | 国土地理院「全国都道府県市区町村別面積調」 |
| 可住地面積 | Habitable area | 国土地理院 |
| 人口密度 | Population density | 総務省（住民基本台帳） + 国土地理院 |

#### 交通インフラ

| 変数名（日本語） | 変数名（英語） | データソース |
|------------------|----------------|--------------|
| 鉄道駅数 | Number of railway stations | 国土交通省「国土数値情報（鉄道データ）」 |
| 新幹線駅の有無 | Shinkansen station availability | 国土交通省「国土数値情報（鉄道データ）」 |
| 空港の有無 | Airport availability | 国土交通省「国土数値情報（空港データ）」 |
| 高速道路IC数 | Number of highway interchanges | 国土交通省「国土数値情報（高速道路時系列データ）」 |
| 平均通勤時間 | Average commute time | 総務省「社会生活基本調査」 |

#### 産業構造

| 変数名（日本語） | 変数名（英語） | データソース |
|------------------|----------------|--------------|
| 産業別就業者比率 | Employment ratio by industry | 総務省「国勢調査」 |
| 製造業事業所数 | Number of manufacturing establishments | 経済産業省「工業統計調査」 |
| 農業産出額 | Agricultural output | 農林水産省「市町村別農業産出額」 |
| 工業出荷額 | Industrial shipment value | 経済産業省「工業統計調査」 |

#### 人口構成

| 変数名（日本語） | 変数名（英語） | データソース |
|------------------|----------------|--------------|
| 総人口 | Total population | 総務省「住民基本台帳」 |
| 年齢別人口比率 | Age group population ratio | 総務省「住民基本台帳」 |
| 外国人人口比率 | Foreign population ratio | 総務省「住民基本台帳」 |
| 平均世帯人員 | Average household size | 総務省「国勢調査」 |

#### 教育・研究機関

| 変数名（日本語） | 変数名（英語） | データソース |
|------------------|----------------|--------------|
| 大学数 | Number of universities | 文部科学省「学校基本調査」 |
| 大学生数 | Number of university students | 文部科学省「学校基本調査」 |
| 研究機関数 | Number of research institutions | 総務省「科学技術研究調査」 |
| 図書館数 | Number of libraries | 文部科学省「社会教育調査」 |

#### 医療・福祉

| 変数名（日本語） | 変数名（英語） | データソース |
|------------------|----------------|--------------|
| 病院数 | Number of hospitals | 厚生労働省「医療施設調査」 |
| 医師数 | Number of physicians | 厚生労働省「医師・歯科医師・薬剤師統計」 |
| 保育所数 | Number of nursery schools | 厚生労働省「社会福祉施設等調査」 |
| 待機児童数 | Number of children on waiting list | 厚生労働省「保育所等関連状況取りまとめ」 |

#### 住宅・不動産

| 変数名（日本語） | 変数名（英語） | データソース |
|------------------|----------------|--------------|
| 平均住宅価格 | Average housing price | 国土交通省「不動産価格指数」 |
| 平均家賃 | Average rent | 総務省「住宅・土地統計調査」 |
| 持ち家比率 | Home ownership rate | 総務省「住宅・土地統計調査」 |
| 空き家率 | Vacancy rate | 総務省「住宅・土地統計調査」 |

#### 観光・地域資源

| 変数名（日本語） | 変数名（英語） | データソース |
|------------------|----------------|--------------|
| 世界遺産の有無 | World heritage site availability | UNESCO + 文化庁 |
| 国宝・重要文化財数 | Number of national treasures | 文化庁「国指定文化財等データベース」 |
| 温泉地数 | Number of hot spring resorts | 環境省「温泉利用状況」 |
| 宿泊施設数 | Number of accommodation facilities | 観光庁「宿泊旅行統計調査」 |

### 6.3 データ取得のサンプルコード

```r
# ==============================================================================
# 実際の統計データ取得のサンプルコード
# Sample code for fetching actual statistical data
# ==============================================================================

library(tidyverse)
library(estatapi)

# e-Stat APIキーの設定
Sys.setenv(ESTAT_API_KEY = "your_app_id_here")

# ==============================================================================
# 1. 人口データの取得
# ==============================================================================

# 住民基本台帳人口データの取得
get_population_data <- function() {
  # 統計表IDを指定（住民基本台帳人口移動報告）
  stats_data <- estat_getStatsData(
    appId = Sys.getenv("ESTAT_API_KEY"),
    statsDataId = "0003410379"  # 実際の統計表IDに置き換え
  )

  return(stats_data)
}

# ==============================================================================
# 2. 経済データの取得
# ==============================================================================

# 県民経済計算データの取得
get_gdp_data <- function() {
  # 内閣府の県民経済計算データ
  # ※ 県民経済計算はExcelファイルで公開されているため、
  # 手動ダウンロード後にreadxlパッケージで読み込むのが一般的

  library(readxl)

  # ダウンロードしたExcelファイルを読み込み
  gdp_data <- read_excel(
    "path/to/kenmin_keizai_keisan.xlsx",
    sheet = "県内総生産"
  )

  return(gdp_data)
}

# ==============================================================================
# 3. 事業所データの取得
# ==============================================================================

# 経済センサスデータの取得
get_establishment_data <- function() {
  stats_data <- estat_getStatsData(
    appId = Sys.getenv("ESTAT_API_KEY"),
    statsDataId = "0003448236"  # 実際の統計表IDに置き換え
  )

  return(stats_data)
}

# ==============================================================================
# 4. 観光データの取得
# ==============================================================================

# 宿泊旅行統計調査データの取得
get_tourism_data <- function() {
  stats_data <- estat_getStatsData(
    appId = Sys.getenv("ESTAT_API_KEY"),
    statsDataId = "0003432152"  # 実際の統計表IDに置き換え
  )

  return(stats_data)
}

# ==============================================================================
# 5. 国土数値情報の取得
# ==============================================================================

# 国土数値情報から地理データを取得
get_geographic_data <- function() {
  library(kokudosuuchi)

  # 鉄道データの取得
  railway_data <- getKSJData(
    identifier = "N02",
    prefCode = NULL  # 全国を取得
  )

  # 医療機関データの取得
  hospital_data <- getKSJData(
    identifier = "P04",
    prefCode = NULL
  )

  return(list(
    railway = railway_data,
    hospital = hospital_data
  ))
}

# ==============================================================================
# データの統合と保存
# ==============================================================================

# すべてのデータを取得して統合
fetch_and_save_all_data <- function() {

  cat("データ取得を開始します...\n\n")

  # 人口データ
  cat("1. 人口データを取得中...\n")
  population <- get_population_data()
  write_csv(population, "R/data/real_population_data.csv")

  # 事業所データ
  cat("2. 事業所データを取得中...\n")
  establishments <- get_establishment_data()
  write_csv(establishments, "R/data/real_establishment_data.csv")

  # 観光データ
  cat("3. 観光データを取得中...\n")
  tourism <- get_tourism_data()
  write_csv(tourism, "R/data/real_tourism_data.csv")

  cat("\n✓ すべてのデータ取得が完了しました\n")
}
```

---

## 7. データ利用時の注意事項

### 7.1 ライセンスと利用規約

1. **政府統計データ**
   - 多くは「政府標準利用規約（第2.0版）」に基づき、自由に利用可能
   - 出典の明示が必要
   - 二次利用する際は、利用規約を確認

2. **e-Stat API**
   - 無料で利用可能
   - APIキーの取得が必要
   - リクエスト回数制限あり（1日10万リクエストまで）

3. **RESAS API**
   - 無料で利用可能
   - APIキーの取得が必要
   - 商用利用も可能

### 7.2 データの更新頻度

| 統計名 | 更新頻度 | 公表時期 |
|--------|----------|----------|
| 国勢調査 | 5年ごと | 実施年の翌年から順次 |
| 住民基本台帳人口移動報告 | 月次・年次 | 翌月末、翌年1月 |
| 人口推計 | 月次 | 翌月下旬 |
| 経済センサス | 5年ごと | 実施年の翌年から順次 |
| 労働力調査 | 月次 | 翌月末 |
| 家計調査 | 月次 | 翌月初旬 |
| 県民経済計算 | 年次 | 2年後の3月頃 |
| 地価公示 | 年次 | 毎年3月下旬 |

### 7.3 データの品質管理

1. **欠損値の確認**
   - 小規模自治体では一部データが取得できない場合がある
   - 秘匿処理により非公開となっているデータがある

2. **データの整合性**
   - 統計によって地域区分が異なる場合がある
   - 市町村合併により時系列比較が困難な場合がある

3. **データの精度**
   - 推計値と確定値の区別
   - 標本調査と全数調査の違い

---

## 8. 参考資料

### 8.1 公式ドキュメント

- [e-Stat 利用ガイド](https://www.e-stat.go.jp/api/api-info/api-guide)
- [RESAS API仕様書](https://opendata.resas-portal.go.jp/docs/api/v1/index.html)
- [国土数値情報 ダウンロードサービス](https://nlftp.mlit.go.jp/ksj/)

### 8.2 Rパッケージ

- **estatapi**: e-Stat APIのRラッパー
  - GitHub: https://github.com/yutannihilation/estatapi
  - CRAN: https://cran.r-project.org/package=estatapi

- **kokudosuuchi**: 国土数値情報のRラッパー
  - GitHub: https://github.com/yutannihilation/kokudosuuchi
  - CRAN: https://cran.r-project.org/package=kokudosuuchi

- **jpndistrict**: 日本の行政区域データ
  - GitHub: https://github.com/uribo/jpndistrict
  - CRAN: https://cran.r-project.org/package=jpndistrict

### 8.3 関連書籍・文献

- 総務省統計局『統計でみる都道府県・市区町村のすがた』
- 内閣府『地域の経済』シリーズ
- 日本統計協会『日本統計年鑑』

---

## 9. お問い合わせ先

### データに関する問い合わせ

- **e-Stat**: https://www.e-stat.go.jp/help/stat-search-3-0
- **各省庁の統計担当部局**: 各統計の公表ページに記載
- **地方自治体**: 各自治体の統計担当課

### API利用に関する問い合わせ

- **e-Stat API**: estat-api@soumu.go.jp
- **RESAS API**: https://opendata.resas-portal.go.jp/form.html

---

## 更新履歴

- **2026-03-10**: 初版作成
  - 主要な政府統計データソースを網羅
  - API利用方法の記載
  - 変数とデータソースの対応表を作成

---

このドキュメントは、実際の統計データを使用した地域創生研究を行う際のガイドとして作成されました。
データの取得・利用にあたっては、各データソースの利用規約を必ず確認してください。
