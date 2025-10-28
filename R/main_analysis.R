# ==============================================================================
# メイン分析実行スクリプト
# Main Analysis Execution Script
# ==============================================================================
#
# 目的: すべての分析スクリプトを順次実行し、地域創生研究を完遂
# Purpose: Execute all analysis scripts sequentially to complete the 
#          regional revitalization research
#

cat("\n")
cat("========================================================\n")
cat("  地域創生成功因子分析システム\n")
cat("  Regional Revitalization Success Factor Analysis\n")
cat("========================================================\n")
cat("\n")

# 必要なパッケージのインストール確認
cat("パッケージの確認とインストール中...\n")
required_packages <- c("tidyverse", "here", "corrplot", "psych", 
                       "FactoMineR", "randomForest", "caret", 
                       "MASS", "pROC", "ggplot2", "patchwork", 
                       "scales", "lm.beta")

for (pkg in required_packages) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat(sprintf("  インストール中: %s\n", pkg))
    install.packages(pkg, repos = "https://cran.r-project.org", quiet = TRUE)
    suppressPackageStartupMessages(library(pkg, character.only = TRUE))
  }
}

cat("✓ すべてのパッケージが利用可能です\n\n")

# here パッケージで作業ディレクトリを設定
library(here)

# スクリプトのパス
script_dir <- here("R", "scripts")

# ==============================================================================
# 分析パイプラインの実行
# Execute analysis pipeline
# ==============================================================================

tryCatch({
  
  # ステップ 1: データ収集
  cat("ステップ 1/4: データ収集\n")
  cat("----------------------------------------\n")
  source(file.path(script_dir, "01_data_collection.R"))
  cat("\n")
  
  # ステップ 2: アウトカム探索
  cat("ステップ 2/4: アウトカム指標の探索\n")
  cat("----------------------------------------\n")
  source(file.path(script_dir, "02_outcome_exploration.R"))
  cat("\n")
  
  # ステップ 3: 因子分析
  cat("ステップ 3/4: 因子分析\n")
  cat("----------------------------------------\n")
  source(file.path(script_dir, "03_factor_analysis.R"))
  cat("\n")
  
  # ステップ 4: 結果可視化
  cat("ステップ 4/4: 結果の可視化\n")
  cat("----------------------------------------\n")
  source(file.path(script_dir, "04_visualization.R"))
  cat("\n")
  
  # 完了メッセージ
  cat("========================================================\n")
  cat("  分析が正常に完了しました！\n")
  cat("========================================================\n\n")
  
  cat("生成されたファイル:\n")
  cat("  データ:\n")
  cat("    - R/data/outcome_indicators.csv\n")
  cat("    - R/data/regional_factors.csv\n")
  cat("    - R/data/classified_regions.csv\n")
  cat("\n")
  cat("  分析結果:\n")
  cat("    - R/output/factor_importance_ranking.csv\n")
  cat("\n")
  cat("  可視化:\n")
  cat("    - R/output/outcome_correlation_plot.png\n")
  cat("    - R/output/outcome_pca_biplot.png\n")
  cat("    - R/output/rf_importance_*.png\n")
  cat("    - R/output/outcome_distributions.png\n")
  cat("    - R/output/success_level_comparison.png\n")
  cat("    - R/output/factor_importance_ranking.png\n")
  cat("    - R/output/factor_outcome_relationships.png\n")
  cat("\n")
  
}, error = function(e) {
  cat("\n")
  cat("========================================================\n")
  cat("  エラーが発生しました\n")
  cat("========================================================\n")
  cat(sprintf("エラーメッセージ: %s\n", e$message))
  cat("\n")
})
