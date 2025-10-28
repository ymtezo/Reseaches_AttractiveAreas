# ==============================================================================
# 因子分析スクリプト
# Factor Analysis Script
# ==============================================================================
#
# 目的: 地域創生の成功に影響を与える因子を特定・分析
# Purpose: Identify and analyze factors influencing regional revitalization success
#

# 必要なパッケージの読み込み
required_packages <- c("tidyverse", "randomForest", "caret", "MASS", "pROC")

for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat(sprintf("パッケージ '%s' をインストール中...\n", pkg))
    install.packages(pkg, repos = "https://cran.r-project.org")
    library(pkg, character.only = TRUE)
  }
}

# ==============================================================================
# 因子分析関数
# Factor analysis functions
# ==============================================================================

#' データの結合と前処理
#' Merge and preprocess data
#'
#' @param outcome_data アウトカムデータ (outcome data)
#' @param factor_data 因子データ (factor data)
#' @return 結合データ (merged data)
prepare_analysis_data <- function(outcome_data, factor_data) {
  
  cat("\n==== データの結合と前処理 ====\n\n")
  
  # データ結合
  merged_data <- outcome_data %>%
    inner_join(factor_data, by = c("region_id", "year"))
  
  cat(sprintf("✓ %d地域のデータを結合しました\n", nrow(merged_data)))
  
  return(merged_data)
}

#' 重回帰分析による因子の影響推定
#' Estimate factor impacts using multiple regression
#'
#' @param data 分析データ (analysis data)
#' @param outcome_var アウトカム変数名 (outcome variable name)
#' @return 回帰モデル (regression model)
analyze_regression <- function(data, outcome_var = "population_change_rate") {
  
  cat(sprintf("\n==== 重回帰分析: %s ====\n\n", outcome_var))
  
  # 因子変数の選択
  factor_vars <- c("municipal_budget", "has_branding", "ict_level", 
                   "startup_programs", "tourism_budget", 
                   "transport_access", "universities")
  
  # モデル式の作成
  formula_str <- paste(outcome_var, "~", paste(factor_vars, collapse = " + "))
  model_formula <- as.formula(formula_str)
  
  # 重回帰モデルの構築
  lm_model <- lm(model_formula, data = data)
  
  # 結果の表示
  cat("\n回帰係数:\n")
  print(summary(lm_model))
  
  # 標準化回帰係数の計算
  cat("\n標準化回帰係数 (重要度):\n")
  standardized_coefs <- lm.beta::lm.beta(lm_model)
  print(standardized_coefs)
  
  return(lm_model)
}

#' ランダムフォレストによる変数重要度分析
#' Variable importance analysis using Random Forest
#'
#' @param data 分析データ (analysis data)
#' @param outcome_var アウトカム変数名 (outcome variable name)
#' @param output_dir 出力ディレクトリ (output directory)
#' @return RFモデル (Random Forest model)
analyze_random_forest <- function(data, outcome_var = "population_change_rate",
                                 output_dir = NULL) {
  
  cat(sprintf("\n==== ランダムフォレスト分析: %s ====\n\n", outcome_var))
  
  # 因子変数の選択
  factor_vars <- c("municipal_budget", "has_branding", "ict_level", 
                   "startup_programs", "tourism_budget", 
                   "transport_access", "universities")
  
  # データ準備
  rf_data <- data %>%
    select(all_of(c(outcome_var, factor_vars))) %>%
    na.omit()
  
  # モデル式の作成
  formula_str <- paste(outcome_var, "~", paste(factor_vars, collapse = " + "))
  model_formula <- as.formula(formula_str)
  
  # ランダムフォレストモデルの構築
  set.seed(123)
  rf_model <- randomForest(model_formula, data = rf_data, 
                          importance = TRUE, ntree = 500)
  
  # 結果の表示
  cat("\nモデル性能:\n")
  print(rf_model)
  
  cat("\n変数重要度:\n")
  importance_df <- as.data.frame(importance(rf_model))
  importance_df$variable <- rownames(importance_df)
  importance_df <- importance_df %>%
    arrange(desc(`%IncMSE`))
  print(importance_df)
  
  # 変数重要度プロットの保存
  if (!is.null(output_dir)) {
    if (!dir.exists(output_dir)) {
      dir.create(output_dir, recursive = TRUE)
    }
    
    png(file.path(output_dir, 
                  sprintf("rf_importance_%s.png", outcome_var)), 
        width = 800, height = 600)
    varImpPlot(rf_model, main = sprintf("変数重要度: %s", outcome_var))
    dev.off()
    
    cat(sprintf("\n✓ 変数重要度プロットを保存しました\n"))
  }
  
  return(rf_model)
}

#' ロジスティック回帰による成功要因分析
#' Success factor analysis using logistic regression
#'
#' @param data 分析データ (classified data with success_level)
#' @return ロジスティックモデル (logistic model)
analyze_success_factors <- function(data) {
  
  cat("\n==== ロジスティック回帰: 成功要因分析 ====\n\n")
  
  # 成功/非成功のバイナリ変数作成
  analysis_data <- data %>%
    mutate(is_success = ifelse(success_level == "高成功", 1, 0))
  
  # 因子変数の選択
  factor_vars <- c("municipal_budget", "has_branding", "ict_level", 
                   "startup_programs", "tourism_budget", 
                   "transport_access", "universities")
  
  # モデル式の作成
  formula_str <- paste("is_success ~", paste(factor_vars, collapse = " + "))
  model_formula <- as.formula(formula_str)
  
  # ロジスティック回帰モデルの構築
  logit_model <- glm(model_formula, data = analysis_data, 
                     family = binomial(link = "logit"))
  
  # 結果の表示
  cat("\nロジスティック回帰係数:\n")
  print(summary(logit_model))
  
  # オッズ比の計算
  cat("\nオッズ比 (Odds Ratios):\n")
  odds_ratios <- exp(coef(logit_model))
  print(odds_ratios)
  
  return(logit_model)
}

#' 因子の影響度ランキング作成
#' Create factor impact ranking
#'
#' @param lm_models 回帰モデルリスト (list of regression models)
#' @param rf_models RFモデルリスト (list of RF models)
#' @return 影響度ランキング (impact ranking)
create_factor_ranking <- function(lm_models, rf_models) {
  
  cat("\n==== 因子の総合影響度ランキング ====\n\n")
  
  # ここでは簡略化して、RFの変数重要度を基準にランキング
  all_importance <- list()
  
  for (i in seq_along(rf_models)) {
    model_name <- names(rf_models)[i]
    importance_df <- as.data.frame(importance(rf_models[[i]]))
    importance_df$variable <- rownames(importance_df)
    importance_df$outcome <- model_name
    all_importance[[i]] <- importance_df
  }
  
  combined_importance <- bind_rows(all_importance) %>%
    group_by(variable) %>%
    summarise(
      avg_incMSE = mean(`%IncMSE`),
      avg_incNodePurity = mean(IncNodePurity)
    ) %>%
    arrange(desc(avg_incMSE))
  
  cat("\n総合影響度ランキング:\n")
  print(combined_importance)
  
  return(combined_importance)
}

# ==============================================================================
# メイン実行部分
# Main execution
# ==============================================================================

if (!interactive()) {
  cat("\n==== 因子分析スクリプトを実行中 ====\n")
  
  # データ読み込み
  data_dir <- here::here("R", "data")
  outcome_data <- read_csv(file.path(data_dir, "classified_regions.csv"),
                          show_col_types = FALSE)
  factor_data <- read_csv(file.path(data_dir, "regional_factors.csv"),
                         show_col_types = FALSE)
  
  # データ結合
  merged_data <- prepare_analysis_data(outcome_data, factor_data)
  
  # 出力ディレクトリ
  output_dir <- here::here("R", "output")
  
  # 各アウトカムに対する分析
  outcome_vars <- c("population_change_rate", "youth_ratio", "employment_rate")
  
  lm_models <- list()
  rf_models <- list()
  
  for (var in outcome_vars) {
    # 重回帰分析
    lm_models[[var]] <- analyze_regression(merged_data, var)
    
    # ランダムフォレスト分析
    rf_models[[var]] <- analyze_random_forest(merged_data, var, output_dir)
  }
  
  # 成功要因のロジスティック回帰
  logit_model <- analyze_success_factors(merged_data)
  
  # 総合ランキング
  factor_ranking <- create_factor_ranking(lm_models, rf_models)
  
  # 結果を保存
  write_csv(factor_ranking, file.path(output_dir, "factor_importance_ranking.csv"))
  
  cat("\n✓ 因子分析結果を保存しました\n")
  cat("\n==== 完了 ====\n")
}
