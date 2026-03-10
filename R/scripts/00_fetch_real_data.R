# ==============================================================================
# 実際の日本政府統計データ取得スクリプト
# Real Japanese Government Statistical Data Fetching Script
# ==============================================================================
#
# 目的: e-Stat等の公的統計データソースから実データを取得
# Purpose: Fetch real data from official statistical sources like e-Stat
#
# 使用前の準備:
# 1. e-Stat APIキーを取得: https://www.e-stat.go.jp/api/
# 2. 環境変数 ESTAT_API_KEY にAPIキーを設定
#    または、.Renvironファイルに ESTAT_API_KEY="your_key" を記載
#

# 必要なパッケージの読み込み
# Load required packages
required_packages <- c("tidyverse", "readr", "dplyr", "httr", "jsonlite")

for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat(sprintf("パッケージ '%s' をインストール中...\n", pkg))
    install.packages(pkg, repos = "https://cran.r-project.org")
    library(pkg, character.only = TRUE)
  }
}

# estatapi パッケージのインストール（e-Stat APIアクセス用）
if (!require("estatapi", quietly = TRUE)) {
  cat("estatapi パッケージをインストール中...\n")
  install.packages("estatapi", repos = "https://cran.r-project.org")
  library(estatapi)
}

# ==============================================================================
# APIキーの確認
# ==============================================================================

check_api_key <- function() {
  api_key <- Sys.getenv("ESTAT_API_KEY")

  if (api_key == "") {
    cat("================================================\n")
    cat("警告: e-Stat APIキーが設定されていません\n")
    cat("================================================\n\n")
    cat("以下の手順でAPIキーを取得・設定してください:\n\n")
    cat("1. e-Statサイトにアクセス: https://www.e-stat.go.jp/\n")
    cat("2. ユーザー登録してログイン\n")
    cat("3. API機能（アプリケーションID発行）にアクセス\n")
    cat("   https://www.e-stat.go.jp/api/\n")
    cat("4. アプリケーションIDを取得\n\n")
    cat("5. 以下のいずれかの方法でAPIキーを設定:\n\n")
    cat("   方法A: Rスクリプト内で設定（一時的）\n")
    cat("   Sys.setenv(ESTAT_API_KEY = \"your_app_id_here\")\n\n")
    cat("   方法B: .Renvironファイルに記載（永続的）\n")
    cat("   ホームディレクトリの .Renviron ファイルに以下を追加:\n")
    cat("   ESTAT_API_KEY=your_app_id_here\n\n")
    cat("================================================\n\n")

    return(FALSE)
  }

  cat("✓ e-Stat APIキーが設定されています\n")
  return(TRUE)
}

# ==============================================================================
# データ取得関数の定義
# ==============================================================================

#' e-Statから統計表リストを検索
#'
#' @param search_word 検索キーワード
#' @param survey_years 調査年（例: "202300" は2023年）
#' @return 統計表のリスト
search_estat_tables <- function(search_word, survey_years = NULL) {

  api_key <- Sys.getenv("ESTAT_API_KEY")

  if (api_key == "") {
    stop("APIキーが設定されていません。check_api_key()を実行してください。")
  }

  cat(sprintf("e-Statで '%s' を検索中...\n", search_word))

  tryCatch({
    stats_list <- estat_getStatsList(
      appId = api_key,
      searchWord = search_word,
      surveyYears = survey_years,
      lang = "J"
    )

    cat(sprintf("✓ %d件の統計表が見つかりました\n", nrow(stats_list)))
    return(stats_list)

  }, error = function(e) {
    cat("エラー: ", conditionMessage(e), "\n")
    cat("APIキーが正しいか、ネットワーク接続を確認してください。\n")
    return(NULL)
  })
}

#' e-Statから統計データを取得
#'
#' @param stats_data_id 統計表ID
#' @return データフレーム
fetch_estat_data <- function(stats_data_id) {

  api_key <- Sys.getenv("ESTAT_API_KEY")

  if (api_key == "") {
    stop("APIキーが設定されていません。check_api_key()を実行してください。")
  }

  cat(sprintf("統計表ID: %s のデータを取得中...\n", stats_data_id))

  tryCatch({
    data <- estat_getStatsData(
      appId = api_key,
      statsDataId = stats_data_id,
      lang = "J"
    )

    cat(sprintf("✓ %d行 x %d列のデータを取得しました\n", nrow(data), ncol(data)))
    return(data)

  }, error = function(e) {
    cat("エラー: ", conditionMessage(e), "\n")
    return(NULL)
  })
}

#' 人口データの取得（住民基本台帳）
#'
#' @return 人口データのデータフレーム
fetch_population_data <- function() {

  cat("\n=== 人口データの取得 ===\n")

  # 住民基本台帳人口で検索
  stats_list <- search_estat_tables("住民基本台帳", survey_years = "202300-")

  if (is.null(stats_list) || nrow(stats_list) == 0) {
    cat("住民基本台帳データが見つかりませんでした\n")
    return(NULL)
  }

  # 最初の統計表を取得（実際にはstats_listから適切なものを選択）
  cat("\n利用可能な統計表:\n")
  print(stats_list[1:min(5, nrow(stats_list)), c("@id", "TITLE", "SURVEY_DATE")])

  cat("\n最初の統計表を取得します...\n")
  data <- fetch_estat_data(stats_list$`@id`[1])

  return(data)
}

#' 経済センサスデータの取得
#'
#' @return 事業所データのデータフレーム
fetch_establishment_data <- function() {

  cat("\n=== 経済センサスデータの取得 ===\n")

  # 経済センサスで検索
  stats_list <- search_estat_tables("経済センサス 事業所")

  if (is.null(stats_list) || nrow(stats_list) == 0) {
    cat("経済センサスデータが見つかりませんでした\n")
    return(NULL)
  }

  # 利用可能な統計表を表示
  cat("\n利用可能な統計表:\n")
  print(stats_list[1:min(5, nrow(stats_list)), c("@id", "TITLE", "SURVEY_DATE")])

  cat("\n最初の統計表を取得します...\n")
  data <- fetch_estat_data(stats_list$`@id`[1])

  return(data)
}

#' 労働力調査データの取得
#'
#' @return 労働力データのデータフレーム
fetch_labor_data <- function() {

  cat("\n=== 労働力調査データの取得 ===\n")

  # 労働力調査で検索
  stats_list <- search_estat_tables("労働力調査 都道府県", survey_years = "202300-")

  if (is.null(stats_list) || nrow(stats_list) == 0) {
    cat("労働力調査データが見つかりませんでした\n")
    return(NULL)
  }

  # 利用可能な統計表を表示
  cat("\n利用可能な統計表:\n")
  print(stats_list[1:min(5, nrow(stats_list)), c("@id", "TITLE", "SURVEY_DATE")])

  cat("\n最初の統計表を取得します...\n")
  data <- fetch_estat_data(stats_list$`@id`[1])

  return(data)
}

#' RESASから地域経済データを取得
#'
#' @param pref_code 都道府県コード（例: 13 = 東京都）
#' @param city_code 市区町村コード（例: 13101 = 千代田区）
#' @return 地域経済データ
#' @note RESAS APIキーが必要: https://opendata.resas-portal.go.jp/
fetch_resas_data <- function(pref_code = "13", city_code = "-") {

  resas_api_key <- Sys.getenv("RESAS_API_KEY")

  if (resas_api_key == "") {
    cat("RESAS APIキーが設定されていません\n")
    cat("取得方法: https://opendata.resas-portal.go.jp/\n")
    return(NULL)
  }

  cat("\n=== RESASデータの取得 ===\n")
  cat(sprintf("都道府県コード: %s, 市区町村コード: %s\n", pref_code, city_code))

  # 人口構成データの取得
  url <- "https://opendata.resas-portal.go.jp/api/v1/population/composition/perYear"

  tryCatch({
    response <- GET(
      url,
      query = list(prefCode = pref_code, cityCode = city_code),
      add_headers(`X-API-KEY` = resas_api_key)
    )

    if (status_code(response) == 200) {
      data <- fromJSON(content(response, "text", encoding = "UTF-8"))
      cat("✓ RESASデータを取得しました\n")
      return(data)
    } else {
      cat(sprintf("エラー: HTTPステータスコード %d\n", status_code(response)))
      return(NULL)
    }

  }, error = function(e) {
    cat("エラー: ", conditionMessage(e), "\n")
    return(NULL)
  })
}

# ==============================================================================
# 実データを使用した分析用データセットの作成
# ==============================================================================

#' 実データから分析用のアウトカム指標データを作成
#'
#' @return アウトカム指標データフレーム
create_real_outcome_data <- function() {

  cat("\n==================================================\n")
  cat("実データを使用したアウトカム指標データの作成\n")
  cat("==================================================\n\n")

  # 実装例: 複数のデータソースから必要なデータを取得・統合

  cat("注意: この関数は実装のサンプルです。\n")
  cat("実際には、複数の統計データを取得し、地域IDで結合する必要があります。\n\n")

  # 人口データの取得
  population_data <- fetch_population_data()

  # 経済データの取得
  # establishment_data <- fetch_establishment_data()

  # 労働データの取得
  # labor_data <- fetch_labor_data()

  # TODO: 各データを地域単位で結合し、変数定義に合わせて整形

  return(population_data)
}

# ==============================================================================
# メイン実行部分
# ==============================================================================

main <- function() {

  cat("\n")
  cat("==================================================\n")
  cat("実際の日本政府統計データ取得スクリプト\n")
  cat("Real Japanese Government Statistical Data Fetcher\n")
  cat("==================================================\n\n")

  # APIキーの確認
  if (!check_api_key()) {
    cat("\nAPIキーを設定後、再度実行してください。\n")
    return(invisible(NULL))
  }

  cat("\n")
  cat("このスクリプトは、e-Stat APIを使用して実際の統計データを取得します。\n")
  cat("データの取得には時間がかかる場合があります。\n\n")

  # ユーザーに確認
  cat("実行を続けますか? (y/n): ")

  if (interactive()) {
    response <- readline()
    if (tolower(response) != "y") {
      cat("処理を中止しました。\n")
      return(invisible(NULL))
    }
  } else {
    cat("(非インタラクティブモードで実行中)\n")
  }

  # データディレクトリの作成
  data_dir <- here::here("R", "data", "real_data")
  if (!dir.exists(data_dir)) {
    dir.create(data_dir, recursive = TRUE)
  }

  # データの取得と保存
  tryCatch({

    # 人口データ
    population <- fetch_population_data()
    if (!is.null(population)) {
      write_csv(population, file.path(data_dir, "real_population_data.csv"))
      cat(sprintf("✓ 人口データを保存: %s\n",
                  file.path(data_dir, "real_population_data.csv")))
    }

    # 経済センサスデータ（コメントアウト: データサイズが大きいため）
    # establishment <- fetch_establishment_data()
    # if (!is.null(establishment)) {
    #   write_csv(establishment, file.path(data_dir, "real_establishment_data.csv"))
    # }

    # 労働力調査データ（コメントアウト: データサイズが大きいため）
    # labor <- fetch_labor_data()
    # if (!is.null(labor)) {
    #   write_csv(labor, file.path(data_dir, "real_labor_data.csv"))
    # }

    cat("\n==================================================\n")
    cat("データ取得が完了しました\n")
    cat("==================================================\n\n")
    cat("取得したデータは以下のディレクトリに保存されました:\n")
    cat(sprintf("  %s\n", data_dir))
    cat("\n")
    cat("次のステップ:\n")
    cat("1. 取得したデータを確認\n")
    cat("2. 必要に応じてデータの整形・クレンジング\n")
    cat("3. 分析スクリプト（02_outcome_exploration.R等）で使用\n")
    cat("\n")
    cat("詳細は JAPAN_STATISTICAL_DATA_SOURCES.md を参照してください。\n")

  }, error = function(e) {
    cat("\nエラーが発生しました: ", conditionMessage(e), "\n")
    cat("詳細は JAPAN_STATISTICAL_DATA_SOURCES.md を参照してください。\n")
  })
}

# スクリプトが直接実行された場合にメイン関数を実行
if (!interactive() || identical(environment(), globalenv())) {
  # here パッケージの読み込み
  if (!require("here", quietly = TRUE)) {
    install.packages("here", repos = "https://cran.r-project.org")
    library(here)
  }

  main()
}

# ==============================================================================
# 使用例（インタラクティブモード）
# ==============================================================================
#
# # APIキーの設定（一時的）
# Sys.setenv(ESTAT_API_KEY = "your_app_id_here")
#
# # スクリプトの読み込み
# source("R/scripts/00_fetch_real_data.R")
#
# # メイン関数の実行
# main()
#
# # または、個別の関数を使用
# stats_list <- search_estat_tables("人口")
# population_data <- fetch_estat_data(stats_list$`@id`[1])
#
