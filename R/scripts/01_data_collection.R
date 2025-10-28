# ==============================================================================
# 地域創生データ収集スクリプト
# Regional Revitalization Data Collection Script
# ==============================================================================
#
# 目的: 地域創生の成功を示す可能性のあるアウトカム指標のデータを収集・整理
# Purpose: Collect and organize outcome indicators that may indicate 
#          regional revitalization success
#

# 必要なパッケージの読み込み
# Load required packages
required_packages <- c("tidyverse", "readr", "dplyr")

for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat(sprintf("パッケージ '%s' をインストール中...\n", pkg))
    install.packages(pkg, repos = "https://cran.r-project.org")
    library(pkg, character.only = TRUE)
  }
}

# ==============================================================================
# データ収集関数の定義
# Define data collection functions
# ==============================================================================

#' 地域創生アウトカム指標のサンプルデータを生成
#' Generate sample regional revitalization outcome data
#'
#' @param n_regions 地域数 (number of regions)
#' @return データフレーム (data frame with outcome indicators)
generate_sample_outcome_data <- function(n_regions = 100) {
  
  cat("地域創生アウトカム指標のサンプルデータを生成中...\n")
  
  # 地域ID
  region_id <- sprintf("R%04d", 1:n_regions)
  
  # アウトカム指標
  # Outcome indicators:
  # - 人口増減率 (population change rate)
  # - 若年層人口比率 (youth population ratio)
  # - 新規事業所数 (number of new establishments)
  # - 観光客数 (number of tourists)
  # - 平均所得 (average income)
  # - 移住者数 (number of immigrants)
  # - 雇用率 (employment rate)
  
  outcome_data <- tibble(
    region_id = region_id,
    population_change_rate = rnorm(n_regions, mean = -0.5, sd = 2),
    youth_ratio = runif(n_regions, min = 0.08, max = 0.25),
    new_businesses = rpois(n_regions, lambda = 15),
    tourists = round(rnorm(n_regions, mean = 50000, sd = 30000)),
    avg_income = rnorm(n_regions, mean = 4000000, sd = 800000),
    immigrants = rpois(n_regions, lambda = 30),
    employment_rate = runif(n_regions, min = 0.85, max = 0.98),
    year = 2023
  )
  
  cat(sprintf("✓ %d地域分のアウトカムデータを生成しました\n", n_regions))
  
  return(outcome_data)
}

#' 地域特性・施策データのサンプルを生成
#' Generate sample regional characteristics and policy data
#'
#' @param n_regions 地域数 (number of regions)
#' @return データフレーム (data frame with regional characteristics)
generate_sample_factor_data <- function(n_regions = 100) {
  
  cat("地域特性・施策データのサンプルを生成中...\n")
  
  region_id <- sprintf("R%04d", 1:n_regions)
  
  # 因子データ
  # Factor data:
  # - 自治体予算 (municipal budget)
  # - 地域ブランド施策有無 (regional branding initiative)
  # - ICT推進度 (ICT promotion level)
  # - 起業支援プログラム数 (number of startup support programs)
  # - 観光プロモーション費 (tourism promotion budget)
  # - 交通アクセス指数 (transportation access index)
  # - 大学・研究機関数 (number of universities/research institutions)
  
  factor_data <- tibble(
    region_id = region_id,
    municipal_budget = rnorm(n_regions, mean = 50000000000, sd = 20000000000),
    has_branding = sample(c(0, 1), n_regions, replace = TRUE, prob = c(0.4, 0.6)),
    ict_level = sample(1:5, n_regions, replace = TRUE),
    startup_programs = rpois(n_regions, lambda = 3),
    tourism_budget = rnorm(n_regions, mean = 500000000, sd = 200000000),
    transport_access = runif(n_regions, min = 1, max = 10),
    universities = rpois(n_regions, lambda = 2),
    year = 2023
  )
  
  cat(sprintf("✓ %d地域分の因子データを生成しました\n", n_regions))
  
  return(factor_data)
}

# ==============================================================================
# メイン実行部分
# Main execution
# ==============================================================================

if (!interactive()) {
  cat("\n==== 地域創生データ収集スクリプトを実行中 ====\n\n")
  
  # サンプルデータ生成
  outcome_data <- generate_sample_outcome_data(n_regions = 100)
  factor_data <- generate_sample_factor_data(n_regions = 100)
  
  # データ保存
  data_dir <- here::here("R", "data")
  if (!dir.exists(data_dir)) {
    dir.create(data_dir, recursive = TRUE)
  }
  
  write_csv(outcome_data, file.path(data_dir, "outcome_indicators.csv"))
  write_csv(factor_data, file.path(data_dir, "regional_factors.csv"))
  
  cat("\n✓ データを保存しました:\n")
  cat(sprintf("  - %s\n", file.path(data_dir, "outcome_indicators.csv")))
  cat(sprintf("  - %s\n", file.path(data_dir, "regional_factors.csv")))
  cat("\n==== 完了 ====\n")
}
