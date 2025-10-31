# 地域研究用変数定義ガイド
# Regional Research Variables Definition Guide

## 概要 (Overview)

このドキュメントでは、`variables_definition.R`に定義されている変数の構造と使用方法について説明します。

## ファイル構成

### 1. アウトカム変数 (`outcome_variables`)

地域が成功しているかを測定するための指標。以下のカテゴリに分類され、データソース別に整理されています：

#### カテゴリ一覧

1. **政府統計・公的機関データ (`government_statistics`)**
   - 経済指標：地域内総生産、一人当たりGDP、経済成長率
   - 人口動態：人口増減率、社会増減率、自然増減率、合計特殊出生率
   - 雇用・所得：平均所得、有効求人倍率、完全失業率
   - 財政：財政力指数、実質公債費比率
   - 教育：大学進学率、学力水準
   - 健康・医療：平均寿命、健康寿命、医療費
   - 安全・治安：犯罪認知件数、交通事故発生率

2. **家計調査データ (`household_survey`)**
   - 趣味娯楽費割合、教育費割合、外食費割合
   - 貯蓄率、消費支出総額

3. **アンケート・主観的指標 (`survey_data`)**
   - 幸福度、生活満足度、地域への愛着度
   - 定住意向、子育てしやすさ評価

4. **民間企業・研究機関データ (`private_data`)**
   - 地価上昇率、小売販売額、観光客数
   - 宿泊施設稼働率、新規事業所開設率、企業誘致数

5. **環境・インフラ指標 (`environment_infrastructure`)**
   - CO2排出量、再生可能エネルギー導入率
   - 公園面積、水道普及率、下水道普及率

6. **デジタル・通信 (`digital_communication`)**
   - ブロードバンド普及率、ICT利活用度
   - 電子自治体成熟度

7. **独自指標 (`original_indicators`)**
   - 若年層流入率、文化施設充実度、スポーツ施設充実度
   - 飲食店多様性指数、イベント開催頻度、起業率
   - ワークライフバランス指数、クリエイティブ産業従事者比率

### 2. 地域特性変数 (`regional_characteristic_variables`)

地域ごとに取得可能な特性データ。以下のカテゴリに分類されています：

#### カテゴリ一覧

1. **地理・位置 (`geography_location`)**
   - 都道府県コード、市区町村コード、地方区分
   - 政令指定都市フラグ、中核市フラグ
   - 面積、可住地面積、人口密度
   - 海岸線の有無、大都市圏からの距離

2. **交通インフラ (`transportation`)**
   - 鉄道駅数、駅密度、新幹線駅の有無
   - 空港の有無、高速道路IC数、道路密度
   - バス路線数、公共交通利便性指数、平均通勤時間

3. **産業構造 (`industry`)**
   - 第一次・第二次・第三次産業就業者比率
   - 製造業・小売業・飲食店の事業所数
   - 農業産出額、工業出荷額、商業販売額

4. **人口構成 (`population`)**
   - 総人口、年齢別人口比率（年少・生産年齢・老年）
   - 外国人人口比率、平均年齢
   - 世帯数、平均世帯人員、単身世帯比率

5. **教育・研究機関 (`education_research`)**
   - 大学数、大学生数、高等学校数、小中学校数
   - 研究機関数、図書館数、博物館・美術館数

6. **医療・福祉 (`medical_welfare`)**
   - 病院数、病床数、医師数、診療所数
   - 保育所数、待機児童数、介護施設数

7. **商業・サービス施設 (`commercial_service`)**
   - 大型商業施設数、コンビニ数、スーパー数
   - 銀行支店数、郵便局数

8. **文化・娯楽・スポーツ施設 (`culture_entertainment`)**
   - 映画館数、スクリーン数、劇場・ホール数
   - 体育館・運動場数、プール数、公園数

9. **住宅・不動産 (`housing`)**
   - 平均住宅価格、平均家賃、持ち家比率
   - 新築住宅着工戸数、空き家率

10. **環境・自然 (`environment`)**
    - 森林面積率、自然公園面積
    - 年間降水量、平均気温、日照時間、災害リスク指標

11. **行政・政治 (`administration`)**
    - 首長の年齢・性別、議会議員数、女性議員比率
    - 投票率、行政サービス電子化率

12. **デジタル・ICT (`digital`)**
    - 光ファイバー世帯カバー率、5Gエリアカバー率
    - Wi-Fiスポット数、IT企業数

13. **観光・地域資源 (`tourism`)**
    - 世界遺産の有無、国宝・重要文化財数
    - 温泉地数、宿泊施設数、観光案内所数、地域ブランド数

14. **近隣・広域関係 (`regional_relations`)**
    - 所属する広域行政圏、経済圏の中心都市
    - 隣接自治体数、都道府県庁所在地までの距離
    - 東京までの所要時間、最寄り政令市までの距離

## 使用方法

### R言語での読み込み

```r
# ファイルを読み込む
source("variables_definition.R")

# アウトカム変数の一覧を表示
names(outcome_variables)

# 政府統計カテゴリの変数名を取得
government_vars <- names(outcome_variables$government_statistics)
print(government_vars)

# 特定の変数の詳細を確認
outcome_variables$government_statistics$`地域内総生産（GDP）`

# 地域特性変数の一覧を表示
names(regional_characteristic_variables)

# 交通インフラ関連の変数を取得
transport_vars <- regional_characteristic_variables$transportation
print(names(transport_vars))
```

### すべての変数名を取得する例

```r
# アウトカム変数のすべての名前を取得
all_outcome_names <- unlist(lapply(outcome_variables, names))
print(all_outcome_names)

# 地域特性変数のすべての名前を取得
all_regional_names <- unlist(lapply(regional_characteristic_variables, names))
print(all_regional_names)
```

### 変数情報をデータフレームに変換する例

```r
# アウトカム変数をデータフレームに変換
library(tidyverse)

outcome_df <- map_dfr(names(outcome_variables), function(category) {
  map_dfr(names(outcome_variables[[category]]), function(var_name) {
    var_info <- outcome_variables[[category]][[var_name]]
    tibble(
      category = category,
      variable_name_jp = var_name,
      variable_name_en = var_info$name,
      source = var_info$source,
      unit = ifelse(is.null(var_info$unit), NA, var_info$unit),
      frequency = ifelse(is.null(var_info$frequency), NA, var_info$frequency)
    )
  })
})

# CSVファイルとして保存
write.csv(outcome_df, "outcome_variables_list.csv", row.names = FALSE, fileEncoding = "UTF-8")
```

## データソース情報

各変数には以下の情報が含まれています：

- **name**: 英語名
- **source**: データの入手先
- **unit**: 単位（該当する場合）
- **frequency**: データの更新頻度（該当する場合）
- **type**: データ型（地域特性変数の場合）
- **note**: 補足情報（該当する場合）

## データ取得時の注意点

1. **統計年次の確認**: 各統計の最新年次を確認してください
2. **地域単位**: 都道府県レベル、市区町村レベルなど、統計によって利用可能な地域単位が異なります
3. **計算が必要な指標**: 一部の指標は、複数のデータソースを組み合わせて算出する必要があります
4. **データの欠損**: すべての地域でデータが取得できるとは限りません

## メタデータ

変数定義のメタデータは`variable_metadata`に格納されています：

```r
# メタデータの確認
print(variable_metadata)
```

## 更新履歴

- **Version 1.0** (2025-10-28): 初版作成
  - アウトカム変数: 7カテゴリ、計51個の変数
  - 地域特性変数: 14カテゴリ、計96個の変数

## 参考リンク

### 主要なデータソース

- [e-Stat](https://www.e-stat.go.jp/) - 政府統計の総合窓口
- [内閣府 県民経済計算](https://www.esri.cao.go.jp/jp/sna/data/data_list/kenmin/files/files_kenmin.html)
- [総務省 住民基本台帳](https://www.soumu.go.jp/main_sosiki/jichi_gyousei/daityo/)
- [厚生労働省 統計情報・白書](https://www.mhlw.go.jp/toukei_hakusho/toukei/)
- [国土交通省 国土数値情報](https://nlftp.mlit.go.jp/ksj/)
- [経済産業省 経済解析室](https://www.meti.go.jp/statistics/)

## ライセンス

このプロジェクトのライセンスについては、リポジトリのLICENSEファイルを参照してください。
