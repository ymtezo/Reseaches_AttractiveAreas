# データ構造仕様書
# Data Structure Specification

## 概要

本プロジェクトで使用するデータの構造と各変数の定義を説明します。

## 1. アウトカム指標データ (outcome_indicators.csv)

地域創生の成功を測定するための結果指標データ

### 変数定義

| 変数名 | データ型 | 説明 | 単位 |
|--------|----------|------|------|
| region_id | character | 地域ID（一意識別子） | - |
| population_change_rate | numeric | 人口増減率 | % |
| youth_ratio | numeric | 若年層（15-39歳）人口比率 | 比率（0-1） |
| new_businesses | integer | 新規事業所数 | 件数 |
| tourists | integer | 年間観光客数 | 人 |
| avg_income | numeric | 平均年収 | 円 |
| immigrants | integer | 年間移住者数 | 人 |
| employment_rate | numeric | 雇用率 | 比率（0-1） |
| year | integer | 対象年 | 年 |

### サンプル

```
region_id,population_change_rate,youth_ratio,new_businesses,tourists,avg_income,immigrants,employment_rate,year
R0001,-0.5,0.15,12,45000,4000000,25,0.92,2023
R0002,0.3,0.18,20,65000,4500000,35,0.95,2023
```

## 2. 地域因子データ (regional_factors.csv)

地域の特性や施策を表す説明変数データ

### 変数定義

| 変数名 | データ型 | 説明 | 単位 |
|--------|----------|------|------|
| region_id | character | 地域ID（一意識別子） | - |
| municipal_budget | numeric | 自治体の年間予算 | 円 |
| has_branding | integer | 地域ブランド施策の有無 | 0=なし, 1=あり |
| ict_level | integer | ICT推進レベル | 1-5（5が最高） |
| startup_programs | integer | 起業支援プログラム数 | 件数 |
| tourism_budget | numeric | 観光プロモーション予算 | 円 |
| transport_access | numeric | 交通アクセス指数 | 1-10（10が最高） |
| universities | integer | 大学・研究機関数 | 施設数 |
| year | integer | 対象年 | 年 |

### サンプル

```
region_id,municipal_budget,has_branding,ict_level,startup_programs,tourism_budget,transport_access,universities,year
R0001,50000000000,1,3,5,500000000,6.5,2,2023
R0002,45000000000,0,4,3,300000000,7.2,1,2023
```

## 3. 分類済み地域データ (classified_regions.csv)

アウトカムデータに成功レベル分類を追加したデータ

### 追加変数定義

| 変数名 | データ型 | 説明 | 値 |
|--------|----------|------|-----|
| pop_norm | numeric | 正規化人口増減率 | 0-1 |
| youth_norm | numeric | 正規化若年層比率 | 0-1 |
| emp_norm | numeric | 正規化雇用率 | 0-1 |
| success_index | numeric | 複合成功指数 | 0-1 |
| success_level | character | 成功レベル分類 | "高成功", "中程度", "課題" |

### 分類基準

- **高成功**: success_index が上位25%以上
- **中程度**: success_index が25%-75%
- **課題**: success_index が下位25%未満

## 4. 因子重要度ランキング (factor_importance_ranking.csv)

各因子の影響度を定量化したランキングデータ

### 変数定義

| 変数名 | データ型 | 説明 |
|--------|----------|------|
| variable | character | 因子名 |
| avg_incMSE | numeric | 平均 %IncMSE（予測精度への影響度） |
| avg_incNodePurity | numeric | 平均ノード純度増加量 |

### 解釈

- `avg_incMSE`: 値が大きいほど、その因子がアウトカムの予測に重要
- `avg_incNodePurity`: 値が大きいほど、その因子による分散説明力が高い

## データ取得方法

### サンプルデータの生成

現在のバージョンでは、分析手法のデモンストレーションのため、統計的に妥当なサンプルデータを自動生成しています。

```r
# スクリプトを実行してサンプルデータを生成
source("R/scripts/01_data_collection.R")
```

### 実データの統合（今後の実装）

実際の研究では、以下のような公開統計データソースからデータを取得することを想定：

1. **総務省 e-Stat**: 人口動態、事業所統計
2. **観光庁**: 観光客数、宿泊統計
3. **内閣府**: 地域経済分析システム (RESAS)
4. **自治体公開データ**: 各種地域施策情報

## データ品質管理

### 欠損値の扱い

- 分析時には `na.omit()` で欠損値を除外
- 必要に応じて補完方法を検討（平均値、中央値、回帰補完等）

### データ検証

各スクリプトで以下の検証を実施：

- 範囲チェック（例: 比率は0-1の範囲内）
- 整合性チェック（例: region_id の一致）
- 外れ値の検出と対処

## 更新履歴

- 2023-XX-XX: 初版作成
- サンプルデータ生成機能の実装
