# ==============================================================================
# アウトカム指標探索スクリプト
# Outcome Indicator Exploration Script
# ==============================================================================
#
# 目的: 地域創生の成功を示すアウトカム指標を探索・評価
# Purpose: Explore and evaluate outcome indicators for regional revitalization success
#

# 必要なパッケージの読み込み
required_packages <- c("tidyverse", "corrplot", "psych", "FactoMineR")

for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat(sprintf("パッケージ '%s' をインストール中...\n", pkg))
    install.packages(pkg, repos = "https://cran.r-project.org")
    library(pkg, character.only = TRUE)
  }
}

# ==============================================================================
# アウトカム探索関数
# Outcome exploration functions
# ==============================================================================

#' アウトカム指標の記述統計を計算
#' Calculate descriptive statistics for outcome indicators
#'
#' @param data アウトカムデータ (outcome data)
#' @return 記述統計の結果 (descriptive statistics results)
explore_outcome_statistics <- function(data) {
  
  cat("\n==== アウトカム指標の記述統計 ====\n\n")
  
  # 数値列のみを選択
  numeric_cols <- data %>% 
    select(where(is.numeric), -year) %>%
    names()
  
  # 記述統計
  desc_stats <- data %>%
    select(all_of(numeric_cols)) %>%
    describe() %>%
    as_tibble(rownames = "variable")
  
  print(desc_stats)
  
  return(desc_stats)
}

#' アウトカム指標間の相関分析
#' Correlation analysis among outcome indicators
#'
#' @param data アウトカムデータ (outcome data)
#' @param output_dir 出力ディレクトリ (output directory)
#' @return 相関行列 (correlation matrix)
analyze_outcome_correlations <- function(data, output_dir = NULL) {
  
  cat("\n==== アウトカム指標の相関分析 ====\n\n")
  
  # 数値列のみを選択
  numeric_data <- data %>% 
    select(where(is.numeric), -year)
  
  # 相関行列の計算
  cor_matrix <- cor(numeric_data, use = "complete.obs")
  
  print(round(cor_matrix, 3))
  
  # 相関図の作成と保存
  if (!is.null(output_dir)) {
    if (!dir.exists(output_dir)) {
      dir.create(output_dir, recursive = TRUE)
    }
    
    png(file.path(output_dir, "outcome_correlation_plot.png"), 
        width = 800, height = 800)
    corrplot(cor_matrix, method = "color", type = "upper",
             tl.col = "black", tl.srt = 45,
             addCoef.col = "black", number.cex = 0.7,
             title = "アウトカム指標の相関マトリクス")
    dev.off()
    
    cat(sprintf("\n✓ 相関図を保存: %s\n", 
                file.path(output_dir, "outcome_correlation_plot.png")))
  }
  
  return(cor_matrix)
}

#' 主成分分析によるアウトカム指標の次元削減
#' Dimensionality reduction of outcome indicators using PCA
#'
#' @param data アウトカムデータ (outcome data)
#' @param output_dir 出力ディレクトリ (output directory)
#' @return PCA結果 (PCA results)
perform_outcome_pca <- function(data, output_dir = NULL) {
  
  cat("\n==== アウトカム指標の主成分分析 ====\n\n")
  
  # 数値列のみを選択
  numeric_data <- data %>% 
    select(where(is.numeric), -year) %>%
    na.omit()
  
  # PCAの実行
  pca_result <- PCA(numeric_data, scale.unit = TRUE, graph = FALSE)
  
  # 固有値と寄与率の表示
  cat("\n固有値と累積寄与率:\n")
  print(pca_result$eig)
  
  # バイプロットの作成と保存
  if (!is.null(output_dir)) {
    if (!dir.exists(output_dir)) {
      dir.create(output_dir, recursive = TRUE)
    }
    
    png(file.path(output_dir, "outcome_pca_biplot.png"), 
        width = 800, height = 800)
    plot(pca_result, choix = "var", 
         title = "アウトカム指標のPCAバイプロット")
    dev.off()
    
    cat(sprintf("\n✓ PCAバイプロットを保存: %s\n", 
                file.path(output_dir, "outcome_pca_biplot.png")))
  }
  
  return(pca_result)
}

#' 成功地域と課題地域の分類
#' Classify regions into successful and challenging categories
#'
#' @param data アウトカムデータ (outcome data)
#' @return 分類されたデータ (classified data)
classify_regions <- function(data) {
  
  cat("\n==== 地域の成功度分類 ====\n\n")
  
  # 複合指標の作成（人口増減率、若年層比率、雇用率の正規化した合計）
  data_classified <- data %>%
    mutate(
      # 各指標を0-1スケールに正規化
      pop_norm = (population_change_rate - min(population_change_rate)) / 
                 (max(population_change_rate) - min(population_change_rate)),
      youth_norm = (youth_ratio - min(youth_ratio)) / 
                   (max(youth_ratio) - min(youth_ratio)),
      emp_norm = (employment_rate - min(employment_rate)) / 
                 (max(employment_rate) - min(employment_rate)),
      
      # 複合成功指数
      success_index = (pop_norm + youth_norm + emp_norm) / 3,
      
      # 成功レベル分類
      success_level = case_when(
        success_index >= quantile(success_index, 0.75) ~ "高成功",
        success_index >= quantile(success_index, 0.25) ~ "中程度",
        TRUE ~ "課題"
      )
    )
  
  # 分類結果のサマリー
  cat("成功レベル別の地域数:\n")
  print(table(data_classified$success_level))
  
  cat("\n成功レベル別の主要指標平均値:\n")
  summary_by_level <- data_classified %>%
    group_by(success_level) %>%
    summarise(
      平均人口増減率 = mean(population_change_rate),
      平均若年層比率 = mean(youth_ratio),
      平均雇用率 = mean(employment_rate),
      平均移住者数 = mean(immigrants),
      地域数 = n()
    )
  print(summary_by_level)
  
  return(data_classified)
}

# ==============================================================================
# メイン実行部分
# Main execution
# ==============================================================================

if (!interactive()) {
  cat("\n==== アウトカム指標探索スクリプトを実行中 ====\n")
  
  # データ読み込み
  data_dir <- here::here("R", "data")
  outcome_data <- read_csv(file.path(data_dir, "outcome_indicators.csv"),
                          show_col_types = FALSE)
  
  # 出力ディレクトリ
  output_dir <- here::here("R", "output")
  
  # 分析実行
  desc_stats <- explore_outcome_statistics(outcome_data)
  cor_matrix <- analyze_outcome_correlations(outcome_data, output_dir)
  pca_result <- perform_outcome_pca(outcome_data, output_dir)
  classified_data <- classify_regions(outcome_data)
  
  # 分類結果を保存
  write_csv(classified_data, file.path(data_dir, "classified_regions.csv"))
  
  cat("\n✓ 分析結果を保存しました\n")
  cat("\n==== 完了 ====\n")
}
