# ==============================================================================
# 結果可視化スクリプト
# Results Visualization Script
# ==============================================================================
#
# 目的: 分析結果を可視化し、レポート用の図表を作成
# Purpose: Visualize analysis results and create figures for reporting
#

# 必要なパッケージの読み込み
required_packages <- c("tidyverse", "ggplot2", "patchwork", "scales")

for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat(sprintf("パッケージ '%s' をインストール中...\n", pkg))
    install.packages(pkg, repos = "https://cran.r-project.org")
    library(pkg, character.only = TRUE)
  }
}

# ==============================================================================
# 可視化関数
# Visualization functions
# ==============================================================================

#' アウトカム指標の分布を可視化
#' Visualize distribution of outcome indicators
#'
#' @param data アウトカムデータ (outcome data)
#' @param output_dir 出力ディレクトリ (output directory)
visualize_outcome_distributions <- function(data, output_dir) {
  
  cat("\n==== アウトカム指標の分布を可視化中 ====\n")
  
  # データを長形式に変換
  plot_data <- data %>%
    select(region_id, population_change_rate, youth_ratio, 
           employment_rate, immigrants) %>%
    pivot_longer(cols = -region_id, 
                names_to = "indicator", 
                values_to = "value")
  
  # 日本語ラベル
  indicator_labels <- c(
    "population_change_rate" = "人口増減率",
    "youth_ratio" = "若年層比率",
    "employment_rate" = "雇用率",
    "immigrants" = "移住者数"
  )
  
  # ヒストグラムの作成
  p <- ggplot(plot_data, aes(x = value)) +
    geom_histogram(bins = 30, fill = "steelblue", alpha = 0.7) +
    facet_wrap(~ indicator, scales = "free", 
               labeller = labeller(indicator = indicator_labels)) +
    theme_minimal() +
    labs(title = "アウトカム指標の分布",
         x = "値", y = "度数") +
    theme(text = element_text(family = "sans"),
          plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))
  
  # 保存
  ggsave(file.path(output_dir, "outcome_distributions.png"), 
         p, width = 10, height = 8, dpi = 300)
  
  cat(sprintf("✓ 保存: %s\n", file.path(output_dir, "outcome_distributions.png")))
}

#' 成功レベル別の比較を可視化
#' Visualize comparison by success level
#'
#' @param data 分類済みデータ (classified data)
#' @param output_dir 出力ディレクトリ (output directory)
visualize_success_comparison <- function(data, output_dir) {
  
  cat("\n==== 成功レベル別比較を可視化中 ====\n")
  
  # 主要指標の平均値を計算
  summary_data <- data %>%
    group_by(success_level) %>%
    summarise(
      人口増減率 = mean(population_change_rate),
      若年層比率 = mean(youth_ratio),
      雇用率 = mean(employment_rate),
      移住者数 = mean(immigrants)
    ) %>%
    pivot_longer(cols = -success_level, 
                names_to = "indicator", 
                values_to = "value")
  
  # 成功レベルの順序設定
  summary_data$success_level <- factor(summary_data$success_level,
                                       levels = c("課題", "中程度", "高成功"))
  
  # 棒グラフの作成
  p <- ggplot(summary_data, aes(x = success_level, y = value, fill = success_level)) +
    geom_bar(stat = "identity", alpha = 0.8) +
    facet_wrap(~ indicator, scales = "free_y") +
    scale_fill_manual(values = c("課題" = "#e74c3c", 
                                  "中程度" = "#f39c12", 
                                  "高成功" = "#27ae60")) +
    theme_minimal() +
    labs(title = "成功レベル別のアウトカム指標比較",
         x = "成功レベル", y = "平均値",
         fill = "成功レベル") +
    theme(text = element_text(family = "sans"),
          plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
          axis.text.x = element_text(angle = 45, hjust = 1))
  
  # 保存
  ggsave(file.path(output_dir, "success_level_comparison.png"), 
         p, width = 10, height = 8, dpi = 300)
  
  cat(sprintf("✓ 保存: %s\n", file.path(output_dir, "success_level_comparison.png")))
}

#' 因子の影響度を可視化
#' Visualize factor impacts
#'
#' @param ranking_data 因子ランキングデータ (factor ranking data)
#' @param output_dir 出力ディレクトリ (output directory)
visualize_factor_importance <- function(ranking_data, output_dir) {
  
  cat("\n==== 因子の影響度を可視化中 ====\n")
  
  # 変数名の日本語化
  var_labels <- c(
    "municipal_budget" = "自治体予算",
    "has_branding" = "地域ブランド施策",
    "ict_level" = "ICT推進度",
    "startup_programs" = "起業支援プログラム",
    "tourism_budget" = "観光プロモーション費",
    "transport_access" = "交通アクセス",
    "universities" = "大学・研究機関"
  )
  
  plot_data <- ranking_data %>%
    mutate(variable_jp = var_labels[variable])
  
  # 棒グラフの作成
  p <- ggplot(plot_data, aes(x = reorder(variable_jp, avg_incMSE), 
                             y = avg_incMSE)) +
    geom_bar(stat = "identity", fill = "steelblue", alpha = 0.8) +
    coord_flip() +
    theme_minimal() +
    labs(title = "因子の総合影響度ランキング",
         subtitle = "ランダムフォレストによる変数重要度の平均",
         x = "因子", y = "重要度 (%IncMSE)") +
    theme(text = element_text(family = "sans"),
          plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
          plot.subtitle = element_text(hjust = 0.5, size = 10))
  
  # 保存
  ggsave(file.path(output_dir, "factor_importance_ranking.png"), 
         p, width = 10, height = 6, dpi = 300)
  
  cat(sprintf("✓ 保存: %s\n", file.path(output_dir, "factor_importance_ranking.png")))
}

#' 因子とアウトカムの散布図を作成
#' Create scatter plots of factors vs outcomes
#'
#' @param data 結合データ (merged data)
#' @param output_dir 出力ディレクトリ (output directory)
visualize_factor_outcome_relationship <- function(data, output_dir) {
  
  cat("\n==== 因子とアウトカムの関係を可視化中 ====\n")
  
  # 主要な因子とアウトカムの組み合わせ
  p1 <- ggplot(data, aes(x = municipal_budget / 1e9, 
                        y = population_change_rate,
                        color = success_level)) +
    geom_point(alpha = 0.6) +
    geom_smooth(method = "lm", se = FALSE, color = "black", linetype = "dashed") +
    scale_color_manual(values = c("課題" = "#e74c3c", 
                                   "中程度" = "#f39c12", 
                                   "高成功" = "#27ae60")) +
    theme_minimal() +
    labs(title = "自治体予算 vs 人口増減率",
         x = "自治体予算 (10億円)", y = "人口増減率 (%)",
         color = "成功レベル")
  
  p2 <- ggplot(data, aes(x = tourism_budget / 1e8, 
                        y = immigrants,
                        color = success_level)) +
    geom_point(alpha = 0.6) +
    geom_smooth(method = "lm", se = FALSE, color = "black", linetype = "dashed") +
    scale_color_manual(values = c("課題" = "#e74c3c", 
                                   "中程度" = "#f39c12", 
                                   "高成功" = "#27ae60")) +
    theme_minimal() +
    labs(title = "観光プロモーション費 vs 移住者数",
         x = "観光プロモーション費 (億円)", y = "移住者数",
         color = "成功レベル")
  
  p3 <- ggplot(data, aes(x = factor(has_branding), 
                        y = youth_ratio,
                        fill = factor(has_branding))) +
    geom_boxplot(alpha = 0.7) +
    scale_fill_manual(values = c("0" = "#95a5a6", "1" = "#3498db"),
                     labels = c("なし", "あり")) +
    theme_minimal() +
    labs(title = "地域ブランド施策 vs 若年層比率",
         x = "地域ブランド施策", y = "若年層比率",
         fill = "施策有無")
  
  p4 <- ggplot(data, aes(x = transport_access, 
                        y = employment_rate,
                        color = success_level)) +
    geom_point(alpha = 0.6) +
    geom_smooth(method = "lm", se = FALSE, color = "black", linetype = "dashed") +
    scale_color_manual(values = c("課題" = "#e74c3c", 
                                   "中程度" = "#f39c12", 
                                   "高成功" = "#27ae60")) +
    theme_minimal() +
    labs(title = "交通アクセス vs 雇用率",
         x = "交通アクセス指数", y = "雇用率",
         color = "成功レベル")
  
  # パッチワークで結合
  combined_plot <- (p1 + p2) / (p3 + p4)
  
  # 保存
  ggsave(file.path(output_dir, "factor_outcome_relationships.png"), 
         combined_plot, width = 14, height = 10, dpi = 300)
  
  cat(sprintf("✓ 保存: %s\n", file.path(output_dir, "factor_outcome_relationships.png")))
}

# ==============================================================================
# メイン実行部分
# Main execution
# ==============================================================================

if (!interactive()) {
  cat("\n==== 結果可視化スクリプトを実行中 ====\n")
  
  # データ読み込み
  data_dir <- here::here("R", "data")
  output_dir <- here::here("R", "output")
  
  outcome_data <- read_csv(file.path(data_dir, "outcome_indicators.csv"),
                          show_col_types = FALSE)
  classified_data <- read_csv(file.path(data_dir, "classified_regions.csv"),
                             show_col_types = FALSE)
  factor_data <- read_csv(file.path(data_dir, "regional_factors.csv"),
                         show_col_types = FALSE)
  ranking_data <- read_csv(file.path(output_dir, "factor_importance_ranking.csv"),
                          show_col_types = FALSE)
  
  # 結合データ
  merged_data <- classified_data %>%
    inner_join(factor_data, by = c("region_id", "year"))
  
  # 可視化実行
  visualize_outcome_distributions(outcome_data, output_dir)
  visualize_success_comparison(classified_data, output_dir)
  visualize_factor_importance(ranking_data, output_dir)
  visualize_factor_outcome_relationship(merged_data, output_dir)
  
  cat("\n✓ すべての可視化を完了しました\n")
  cat("\n==== 完了 ====\n")
}
