# ==============================================================================
# 地域研究用変数定義
# Regional Research Variable Definitions
# ==============================================================================

# ------------------------------------------------------------------------------
# 1. アウトカム変数 (Outcome Variables)
#    地域が成功しているかを測る指標
# ------------------------------------------------------------------------------

outcome_variables <- list(
  
  # 政府統計・公的機関データ (Government Statistics / Official Data)
  government_statistics = list(
    # 経済指標
    "地域内総生産（GDP）" = list(
      name = "Regional GDP",
      source = "内閣府・県民経済計算",
      unit = "百万円",
      frequency = "年次"
    ),
    "一人当たり地域内総生産" = list(
      name = "GDP per capita",
      source = "内閣府・県民経済計算",
      unit = "千円/人",
      frequency = "年次"
    ),
    "地域経済成長率" = list(
      name = "Regional economic growth rate",
      source = "内閣府・県民経済計算",
      unit = "%",
      frequency = "年次"
    ),
    
    # 人口動態
    "人口増減率" = list(
      name = "Population growth rate",
      source = "総務省・住民基本台帳、国勢調査",
      unit = "%",
      frequency = "年次、5年毎"
    ),
    "社会増減率" = list(
      name = "Social population change rate (migration)",
      source = "総務省・住民基本台帳",
      unit = "%",
      frequency = "年次"
    ),
    "自然増減率" = list(
      name = "Natural population change rate",
      source = "総務省・住民基本台帳",
      unit = "%",
      frequency = "年次"
    ),
    "合計特殊出生率" = list(
      name = "Total fertility rate",
      source = "厚生労働省・人口動態統計",
      unit = "人",
      frequency = "年次"
    ),
    
    # 雇用・所得
    "平均所得" = list(
      name = "Average income",
      source = "国税庁・民間給与実態統計調査",
      unit = "千円",
      frequency = "年次"
    ),
    "有効求人倍率" = list(
      name = "Job openings-to-applicants ratio",
      source = "厚生労働省・職業安定業務統計",
      unit = "倍",
      frequency = "月次"
    ),
    "完全失業率" = list(
      name = "Unemployment rate",
      source = "総務省・労働力調査",
      unit = "%",
      frequency = "月次"
    ),
    
    # 財政
    "財政力指数" = list(
      name = "Financial capability index",
      source = "総務省・地方財政状況調査",
      unit = "指数",
      frequency = "年次"
    ),
    "実質公債費比率" = list(
      name = "Real debt service ratio",
      source = "総務省・地方財政状況調査",
      unit = "%",
      frequency = "年次"
    ),
    
    # 教育
    "大学進学率" = list(
      name = "University enrollment rate",
      source = "文部科学省・学校基本調査",
      unit = "%",
      frequency = "年次"
    ),
    "児童生徒学力水準" = list(
      name = "Student academic achievement level",
      source = "文部科学省・全国学力・学習状況調査",
      unit = "点数",
      frequency = "年次"
    ),
    
    # 健康・医療
    "平均寿命" = list(
      name = "Life expectancy",
      source = "厚生労働省・都道府県別生命表",
      unit = "年",
      frequency = "5年毎"
    ),
    "健康寿命" = list(
      name = "Healthy life expectancy",
      source = "厚生労働省",
      unit = "年",
      frequency = "不定期"
    ),
    "医療費（一人当たり）" = list(
      name = "Medical expenses per capita",
      source = "厚生労働省・国民医療費",
      unit = "千円",
      frequency = "年次"
    ),
    
    # 安全・治安
    "刑法犯認知件数（人口千人当たり）" = list(
      name = "Number of recognized criminal offenses per 1000 people",
      source = "警察庁・犯罪統計",
      unit = "件/千人",
      frequency = "年次"
    ),
    "交通事故発生率" = list(
      name = "Traffic accident rate",
      source = "警察庁・交通事故統計",
      unit = "件/千人",
      frequency = "年次"
    )
  ),
  
  # 家計調査データ (Household Survey Data)
  household_survey = list(
    "趣味娯楽費割合" = list(
      name = "Ratio of spending on hobbies and entertainment",
      source = "総務省・家計調査",
      unit = "%",
      frequency = "月次・年次"
    ),
    "教育費割合" = list(
      name = "Ratio of education expenses",
      source = "総務省・家計調査",
      unit = "%",
      frequency = "月次・年次"
    ),
    "外食費割合" = list(
      name = "Ratio of dining out expenses",
      source = "総務省・家計調査",
      unit = "%",
      frequency = "月次・年次"
    ),
    "貯蓄率" = list(
      name = "Savings rate",
      source = "総務省・家計調査",
      unit = "%",
      frequency = "年次"
    ),
    "消費支出総額" = list(
      name = "Total consumption expenditure",
      source = "総務省・家計調査",
      unit = "円",
      frequency = "月次・年次"
    )
  ),
  
  # アンケート・主観的指標 (Survey / Subjective Indicators)
  survey_data = list(
    "幸福度" = list(
      name = "Happiness index",
      source = "内閣府・都道府県別幸福度ランキング、各種民間調査",
      unit = "スコア",
      frequency = "不定期"
    ),
    "生活満足度" = list(
      name = "Life satisfaction",
      source = "内閣府・生活の質に関する調査",
      unit = "スコア",
      frequency = "不定期"
    ),
    "地域への愛着度" = list(
      name = "Attachment to region",
      source = "各種民間調査・自治体調査",
      unit = "スコア",
      frequency = "不定期"
    ),
    "定住意向" = list(
      name = "Intention to continue living",
      source = "各種民間調査・自治体調査",
      unit = "%",
      frequency = "不定期"
    ),
    "子育てしやすさ評価" = list(
      name = "Childcare friendliness rating",
      source = "各種民間調査",
      unit = "スコア",
      frequency = "不定期"
    )
  ),
  
  # 民間企業・研究機関データ (Private Company / Research Institution Data)
  private_data = list(
    "地価上昇率" = list(
      name = "Land price growth rate",
      source = "国土交通省・地価公示、民間不動産データ",
      unit = "%",
      frequency = "年次"
    ),
    "小売販売額" = list(
      name = "Retail sales",
      source = "経済産業省・商業動態統計",
      unit = "百万円",
      frequency = "月次"
    ),
    "観光客数" = list(
      name = "Number of tourists",
      source = "観光庁・宿泊旅行統計調査、自治体統計",
      unit = "人",
      frequency = "月次・年次"
    ),
    "宿泊施設稼働率" = list(
      name = "Accommodation facility occupancy rate",
      source = "観光庁・宿泊旅行統計調査",
      unit = "%",
      frequency = "月次"
    ),
    "新規事業所開設率" = list(
      name = "New business establishment rate",
      source = "総務省・経済センサス",
      unit = "%",
      frequency = "年次"
    ),
    "企業誘致数" = list(
      name = "Number of attracted companies",
      source = "自治体統計",
      unit = "社",
      frequency = "年次"
    )
  ),
  
  # 環境・インフラ指標 (Environment / Infrastructure Indicators)
  environment_infrastructure = list(
    "CO2排出量（一人当たり）" = list(
      name = "CO2 emissions per capita",
      source = "環境省・温室効果ガスインベントリ",
      unit = "t-CO2/人",
      frequency = "年次"
    ),
    "再生可能エネルギー導入率" = list(
      name = "Renewable energy adoption rate",
      source = "経済産業省・エネルギー統計",
      unit = "%",
      frequency = "年次"
    ),
    "公園面積（一人当たり）" = list(
      name = "Park area per capita",
      source = "国土交通省・都市公園等整備現況調査",
      unit = "㎡/人",
      frequency = "年次"
    ),
    "水道普及率" = list(
      name = "Water supply coverage rate",
      source = "厚生労働省・水道統計",
      unit = "%",
      frequency = "年次"
    ),
    "下水道普及率" = list(
      name = "Sewerage coverage rate",
      source = "国土交通省・下水道統計",
      unit = "%",
      frequency = "年次"
    )
  ),
  
  # デジタル・通信 (Digital / Communication)
  digital_communication = list(
    "ブロードバンド普及率" = list(
      name = "Broadband penetration rate",
      source = "総務省・通信利用動向調査",
      unit = "%",
      frequency = "年次"
    ),
    "ICT利活用度" = list(
      name = "ICT utilization level",
      source = "総務省・通信利用動向調査",
      unit = "スコア",
      frequency = "年次"
    ),
    "電子自治体成熟度" = list(
      name = "E-government maturity",
      source = "総務省",
      unit = "スコア",
      frequency = "不定期"
    )
  ),
  
  # 独自指標 (Original Indicators)
  original_indicators = list(
    "若年層流入率" = list(
      name = "Youth inflow rate (15-39 years)",
      source = "総務省・住民基本台帳（計算必要）",
      unit = "%",
      frequency = "年次",
      note = "若年層(15-39歳)の転入超過率"
    ),
    "文化施設充実度" = list(
      name = "Cultural facility enrichment",
      source = "文部科学省・社会教育調査（計算必要）",
      unit = "施設数/十万人",
      frequency = "3年毎",
      note = "図書館、博物館、美術館等の人口当たり数"
    ),
    "スポーツ施設充実度" = list(
      name = "Sports facility enrichment",
      source = "文部科学省・体育・スポーツ施設現況調査（計算必要）",
      unit = "施設数/十万人",
      frequency = "不定期"
    ),
    "飲食店多様性指数" = list(
      name = "Restaurant diversity index",
      source = "経済センサス、民間データ（計算必要）",
      unit = "指数",
      frequency = "年次",
      note = "業態の多様性をシャノン指数等で計算"
    ),
    "イベント開催頻度" = list(
      name = "Event frequency",
      source = "自治体統計、民間イベント情報（収集必要）",
      unit = "件/年",
      frequency = "年次"
    ),
    "起業率（対人口）" = list(
      name = "Entrepreneurship rate",
      source = "経済センサス（計算必要）",
      unit = "%",
      frequency = "年次"
    ),
    "ワークライフバランス指数" = list(
      name = "Work-life balance index",
      source = "各種調査を組み合わせて算出",
      unit = "スコア",
      frequency = "年次",
      note = "労働時間、有給取得率、通勤時間等を総合"
    ),
    "クリエイティブ産業従事者比率" = list(
      name = "Creative industry worker ratio",
      source = "国勢調査・経済センサス（計算必要）",
      unit = "%",
      frequency = "5年毎",
      note = "芸術、デザイン、IT等の従事者割合"
    )
  )
)


# ------------------------------------------------------------------------------
# 2. 地域特性変数 (Regional Characteristic Variables)
#    地域ごとに取得可能なデータ
# ------------------------------------------------------------------------------

regional_characteristic_variables <- list(
  
  # 地理・位置 (Geography / Location)
  geography_location = list(
    "都道府県コード" = list(
      name = "Prefecture code",
      source = "総務省",
      type = "categorical"
    ),
    "市区町村コード" = list(
      name = "Municipality code",
      source = "総務省",
      type = "categorical"
    ),
    "地方区分" = list(
      name = "Regional division",
      source = "総務省",
      type = "categorical",
      categories = c("北海道", "東北", "関東", "中部", "近畿", "中国", "四国", "九州・沖縄")
    ),
    "政令指定都市フラグ" = list(
      name = "Designated city flag",
      source = "総務省",
      type = "binary"
    ),
    "中核市フラグ" = list(
      name = "Core city flag",
      source = "総務省",
      type = "binary"
    ),
    "面積" = list(
      name = "Area",
      source = "国土地理院",
      unit = "km²",
      type = "continuous"
    ),
    "可住地面積" = list(
      name = "Habitable area",
      source = "国土地理院",
      unit = "km²",
      type = "continuous"
    ),
    "人口密度" = list(
      name = "Population density",
      source = "総務省・国勢調査",
      unit = "人/km²",
      type = "continuous"
    ),
    "海岸線の有無" = list(
      name = "Coastal area flag",
      source = "国土地理院",
      type = "binary"
    ),
    "大都市圏の中心からの距離" = list(
      name = "Distance from major metropolitan area",
      source = "計算必要",
      unit = "km",
      type = "continuous"
    )
  ),
  
  # 交通インフラ (Transportation Infrastructure)
  transportation = list(
    "鉄道駅数" = list(
      name = "Number of railway stations",
      source = "国土交通省・国土数値情報",
      unit = "駅",
      type = "count"
    ),
    "鉄道駅密度" = list(
      name = "Railway station density",
      source = "国土交通省（計算必要）",
      unit = "駅/100km²",
      type = "continuous"
    ),
    "新幹線駅の有無" = list(
      name = "Shinkansen station flag",
      source = "国土交通省",
      type = "binary"
    ),
    "空港の有無" = list(
      name = "Airport flag",
      source = "国土交通省",
      type = "binary"
    ),
    "高速道路IC数" = list(
      name = "Number of highway interchanges",
      source = "国土交通省・国土数値情報",
      unit = "箇所",
      type = "count"
    ),
    "道路密度" = list(
      name = "Road density",
      source = "国土交通省・道路統計",
      unit = "km/km²",
      type = "continuous"
    ),
    "バス路線数" = list(
      name = "Number of bus routes",
      source = "国土交通省",
      unit = "路線",
      type = "count"
    ),
    "公共交通利便性指数" = list(
      name = "Public transportation convenience index",
      source = "各種データから算出",
      unit = "スコア",
      type = "continuous"
    ),
    "平均通勤時間" = list(
      name = "Average commute time",
      source = "国勢調査",
      unit = "分",
      type = "continuous"
    )
  ),
  
  # 産業構造 (Industrial Structure)
  industry = list(
    "第一次産業就業者比率" = list(
      name = "Primary industry employment ratio",
      source = "国勢調査",
      unit = "%",
      type = "continuous"
    ),
    "第二次産業就業者比率" = list(
      name = "Secondary industry employment ratio",
      source = "国勢調査",
      unit = "%",
      type = "continuous"
    ),
    "第三次産業就業者比率" = list(
      name = "Tertiary industry employment ratio",
      source = "国勢調査",
      unit = "%",
      type = "continuous"
    ),
    "製造業事業所数" = list(
      name = "Number of manufacturing establishments",
      source = "経済センサス",
      unit = "事業所",
      type = "count"
    ),
    "小売業事業所数" = list(
      name = "Number of retail establishments",
      source = "経済センサス",
      unit = "事業所",
      type = "count"
    ),
    "飲食店数（人口当たり）" = list(
      name = "Number of restaurants per capita",
      source = "経済センサス",
      unit = "店/千人",
      type = "continuous"
    ),
    "農業産出額" = list(
      name = "Agricultural output",
      source = "農林水産省",
      unit = "百万円",
      type = "continuous"
    ),
    "工業出荷額" = list(
      name = "Industrial shipment value",
      source = "経済産業省・工業統計",
      unit = "百万円",
      type = "continuous"
    ),
    "商業販売額" = list(
      name = "Commercial sales",
      source = "経済産業省・商業統計",
      unit = "百万円",
      type = "continuous"
    ),
    "主要産業分類" = list(
      name = "Main industry classification",
      source = "経済センサス",
      type = "categorical"
    )
  ),
  
  # 人口構成 (Population Structure)
  population = list(
    "総人口" = list(
      name = "Total population",
      source = "総務省・住民基本台帳、国勢調査",
      unit = "人",
      type = "continuous"
    ),
    "年少人口比率（0-14歳）" = list(
      name = "Youth population ratio (0-14 years)",
      source = "総務省・住民基本台帳",
      unit = "%",
      type = "continuous"
    ),
    "生産年齢人口比率（15-64歳）" = list(
      name = "Working-age population ratio (15-64 years)",
      source = "総務省・住民基本台帳",
      unit = "%",
      type = "continuous"
    ),
    "老年人口比率（65歳以上）" = list(
      name = "Elderly population ratio (65+ years)",
      source = "総務省・住民基本台帳",
      unit = "%",
      type = "continuous"
    ),
    "外国人人口比率" = list(
      name = "Foreign population ratio",
      source = "総務省・住民基本台帳",
      unit = "%",
      type = "continuous"
    ),
    "平均年齢" = list(
      name = "Average age",
      source = "国勢調査",
      unit = "歳",
      type = "continuous"
    ),
    "世帯数" = list(
      name = "Number of households",
      source = "国勢調査",
      unit = "世帯",
      type = "count"
    ),
    "平均世帯人員" = list(
      name = "Average household size",
      source = "国勢調査",
      unit = "人",
      type = "continuous"
    ),
    "単身世帯比率" = list(
      name = "Single-person household ratio",
      source = "国勢調査",
      unit = "%",
      type = "continuous"
    )
  ),
  
  # 教育・研究機関 (Educational / Research Institutions)
  education_research = list(
    "大学数" = list(
      name = "Number of universities",
      source = "文部科学省・学校基本調査",
      unit = "校",
      type = "count"
    ),
    "大学生数（人口当たり）" = list(
      name = "Number of university students per capita",
      source = "文部科学省・学校基本調査",
      unit = "人/千人",
      type = "continuous"
    ),
    "高等学校数" = list(
      name = "Number of high schools",
      source = "文部科学省・学校基本調査",
      unit = "校",
      type = "count"
    ),
    "小中学校数" = list(
      name = "Number of elementary and junior high schools",
      source = "文部科学省・学校基本調査",
      unit = "校",
      type = "count"
    ),
    "研究機関数" = list(
      name = "Number of research institutions",
      source = "文部科学省",
      unit = "機関",
      type = "count"
    ),
    "図書館数" = list(
      name = "Number of libraries",
      source = "文部科学省・社会教育調査",
      unit = "館",
      type = "count"
    ),
    "博物館・美術館数" = list(
      name = "Number of museums and art galleries",
      source = "文部科学省・社会教育調査",
      unit = "館",
      type = "count"
    )
  ),
  
  # 医療・福祉 (Medical / Welfare)
  medical_welfare = list(
    "病院数" = list(
      name = "Number of hospitals",
      source = "厚生労働省・医療施設調査",
      unit = "施設",
      type = "count"
    ),
    "病床数（人口千人当たり）" = list(
      name = "Number of hospital beds per 1000 people",
      source = "厚生労働省・医療施設調査",
      unit = "床/千人",
      type = "continuous"
    ),
    "医師数（人口千人当たり）" = list(
      name = "Number of physicians per 1000 people",
      source = "厚生労働省・医師・歯科医師・薬剤師調査",
      unit = "人/千人",
      type = "continuous"
    ),
    "診療所数" = list(
      name = "Number of clinics",
      source = "厚生労働省・医療施設調査",
      unit = "施設",
      type = "count"
    ),
    "保育所数" = list(
      name = "Number of nursery schools",
      source = "厚生労働省",
      unit = "施設",
      type = "count"
    ),
    "保育所待機児童数" = list(
      name = "Number of children on nursery school waiting list",
      source = "厚生労働省",
      unit = "人",
      type = "count"
    ),
    "介護施設数" = list(
      name = "Number of nursing care facilities",
      source = "厚生労働省",
      unit = "施設",
      type = "count"
    )
  ),
  
  # 商業・サービス施設 (Commercial / Service Facilities)
  commercial_service = list(
    "大型商業施設数" = list(
      name = "Number of large commercial facilities",
      source = "経済産業省、民間データ",
      unit = "施設",
      type = "count"
    ),
    "コンビニエンスストア数（人口当たり）" = list(
      name = "Number of convenience stores per capita",
      source = "経済センサス",
      unit = "店/千人",
      type = "continuous"
    ),
    "スーパーマーケット数" = list(
      name = "Number of supermarkets",
      source = "経済センサス",
      unit = "店",
      type = "count"
    ),
    "銀行支店数" = list(
      name = "Number of bank branches",
      source = "金融庁、各銀行データ",
      unit = "店",
      type = "count"
    ),
    "郵便局数" = list(
      name = "Number of post offices",
      source = "日本郵便",
      unit = "局",
      type = "count"
    )
  ),
  
  # 文化・娯楽・スポーツ施設 (Culture / Entertainment / Sports Facilities)
  culture_entertainment = list(
    "映画館数" = list(
      name = "Number of movie theaters",
      source = "民間データ",
      unit = "館",
      type = "count"
    ),
    "スクリーン数" = list(
      name = "Number of movie screens",
      source = "民間データ",
      unit = "面",
      type = "count"
    ),
    "劇場・ホール数" = list(
      name = "Number of theaters and halls",
      source = "文部科学省",
      unit = "施設",
      type = "count"
    ),
    "体育館・運動場数" = list(
      name = "Number of gymnasiums and sports grounds",
      source = "文部科学省・体育・スポーツ施設現況調査",
      unit = "施設",
      type = "count"
    ),
    "プール数" = list(
      name = "Number of swimming pools",
      source = "文部科学省・体育・スポーツ施設現況調査",
      unit = "施設",
      type = "count"
    ),
    "公園数" = list(
      name = "Number of parks",
      source = "国土交通省・都市公園等整備現況調査",
      unit = "箇所",
      type = "count"
    )
  ),
  
  # 住宅・不動産 (Housing / Real Estate)
  housing = list(
    "平均住宅価格" = list(
      name = "Average housing price",
      source = "国土交通省・不動産取引価格情報",
      unit = "万円",
      type = "continuous"
    ),
    "平均家賃" = list(
      name = "Average rent",
      source = "総務省・住宅・土地統計調査",
      unit = "円",
      type = "continuous"
    ),
    "持ち家比率" = list(
      name = "Home ownership ratio",
      source = "総務省・住宅・土地統計調査",
      unit = "%",
      type = "continuous"
    ),
    "新築住宅着工戸数" = list(
      name = "Number of new housing starts",
      source = "国土交通省・建築着工統計",
      unit = "戸",
      type = "count"
    ),
    "空き家率" = list(
      name = "Vacancy rate",
      source = "総務省・住宅・土地統計調査",
      unit = "%",
      type = "continuous"
    )
  ),
  
  # 環境・自然 (Environment / Nature)
  environment = list(
    "森林面積率" = list(
      name = "Forest area ratio",
      source = "林野庁",
      unit = "%",
      type = "continuous"
    ),
    "自然公園面積" = list(
      name = "Natural park area",
      source = "環境省",
      unit = "ha",
      type = "continuous"
    ),
    "年間降水量" = list(
      name = "Annual precipitation",
      source = "気象庁",
      unit = "mm",
      type = "continuous"
    ),
    "年間平均気温" = list(
      name = "Annual average temperature",
      source = "気象庁",
      unit = "℃",
      type = "continuous"
    ),
    "日照時間" = list(
      name = "Sunshine hours",
      source = "気象庁",
      unit = "時間",
      type = "continuous"
    ),
    "災害リスク指標" = list(
      name = "Disaster risk index",
      source = "国土交通省・各種ハザードマップ",
      unit = "スコア",
      type = "continuous"
    )
  ),
  
  # 行政・政治 (Administration / Politics)
  administration = list(
    "首長の年齢" = list(
      name = "Mayor/Governor age",
      source = "自治体公開情報",
      unit = "歳",
      type = "continuous"
    ),
    "首長の性別" = list(
      name = "Mayor/Governor gender",
      source = "自治体公開情報",
      type = "categorical"
    ),
    "議会議員数" = list(
      name = "Number of assembly members",
      source = "自治体公開情報",
      unit = "人",
      type = "count"
    ),
    "女性議員比率" = list(
      name = "Female assembly member ratio",
      source = "自治体公開情報",
      unit = "%",
      type = "continuous"
    ),
    "投票率（直近選挙）" = list(
      name = "Voter turnout (latest election)",
      source = "総務省",
      unit = "%",
      type = "continuous"
    ),
    "行政サービス電子化率" = list(
      name = "E-government service rate",
      source = "総務省",
      unit = "%",
      type = "continuous"
    )
  ),
  
  # デジタル・ICT (Digital / ICT)
  digital = list(
    "光ファイバー世帯カバー率" = list(
      name = "Fiber optic household coverage rate",
      source = "総務省",
      unit = "%",
      type = "continuous"
    ),
    "5Gエリアカバー率" = list(
      name = "5G area coverage rate",
      source = "総務省、通信事業者",
      unit = "%",
      type = "continuous"
    ),
    "Wi-Fiスポット数" = list(
      name = "Number of Wi-Fi hotspots",
      source = "民間データ",
      unit = "箇所",
      type = "count"
    ),
    "IT企業数" = list(
      name = "Number of IT companies",
      source = "経済センサス",
      unit = "社",
      type = "count"
    )
  ),
  
  # 観光・地域資源 (Tourism / Regional Resources)
  tourism = list(
    "世界遺産の有無" = list(
      name = "World Heritage Site flag",
      source = "UNESCO",
      type = "binary"
    ),
    "国宝・重要文化財数" = list(
      name = "Number of national treasures and important cultural properties",
      source = "文化庁",
      unit = "件",
      type = "count"
    ),
    "温泉地数" = list(
      name = "Number of hot spring areas",
      source = "環境省",
      unit = "箇所",
      type = "count"
    ),
    "宿泊施設数" = list(
      name = "Number of accommodation facilities",
      source = "観光庁・宿泊旅行統計調査",
      unit = "施設",
      type = "count"
    ),
    "観光案内所数" = list(
      name = "Number of tourist information centers",
      source = "観光庁",
      unit = "箇所",
      type = "count"
    ),
    "地域ブランド数" = list(
      name = "Number of regional brands",
      source = "特許庁・地域団体商標",
      unit = "件",
      type = "count"
    )
  ),
  
  # 近隣・広域関係 (Neighboring / Wide-area Relations)
  regional_relations = list(
    "所属する広域行政圏" = list(
      name = "Belonging wide-area administrative district",
      source = "総務省",
      type = "categorical"
    ),
    "経済圏の中心都市" = list(
      name = "Economic center city",
      source = "分析により設定",
      type = "categorical"
    ),
    "隣接自治体数" = list(
      name = "Number of neighboring municipalities",
      source = "国土地理院",
      unit = "自治体",
      type = "count"
    ),
    "都道府県庁所在地までの距離" = list(
      name = "Distance to prefectural capital",
      source = "計算必要",
      unit = "km",
      type = "continuous"
    ),
    "東京までの所要時間" = list(
      name = "Travel time to Tokyo",
      source = "交通機関データ",
      unit = "分",
      type = "continuous"
    ),
    "最寄り政令市までの距離" = list(
      name = "Distance to nearest designated city",
      source = "計算必要",
      unit = "km",
      type = "continuous"
    )
  )
)


# ------------------------------------------------------------------------------
# メタデータ
# ------------------------------------------------------------------------------

variable_metadata <- list(
  created_date = Sys.Date(),
  version = "1.0",
  description = "地域の成功指標とその要因を分析するための変数定義",
  outcome_variables_count = sum(sapply(outcome_variables, length)),
  regional_characteristic_variables_count = sum(sapply(regional_characteristic_variables, length)),
  notes = c(
    "データ取得時は最新の統計年次を確認すること",
    "一部の変数は複数のデータソースを組み合わせて算出する必要がある",
    "市区町村レベルでデータが取得できない変数もあるため、分析単位に応じて選択すること"
  )
)


# ------------------------------------------------------------------------------
# 使用例
# ------------------------------------------------------------------------------

# アウトカム変数の一覧を取得
# outcome_var_names <- unlist(lapply(outcome_variables, names))

# 特定カテゴリの変数を取得
# govt_stats <- outcome_variables$government_statistics

# 地域特性変数の一覧を取得
# regional_var_names <- unlist(lapply(regional_characteristic_variables, names))

# 特定カテゴリの変数を取得
# transport_vars <- regional_characteristic_variables$transportation
