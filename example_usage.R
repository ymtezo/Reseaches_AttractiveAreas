# ==============================================================================
# 変数定義の使用例
# Example Usage of Variable Definitions
# ==============================================================================

# 変数定義ファイルを読み込む
source("variables_definition.R")

# ------------------------------------------------------------------------------
# 例1: アウトカム変数の一覧を取得
# ------------------------------------------------------------------------------

cat("=== アウトカム変数のカテゴリ ===\n")
print(names(outcome_variables))
cat("\n")

# 各カテゴリの変数数を表示
cat("=== 各カテゴリの変数数 ===\n")
for (category in names(outcome_variables)) {
  count <- length(outcome_variables[[category]])
  cat(sprintf("%s: %d個\n", category, count))
}
cat("\n")

# ------------------------------------------------------------------------------
# 例2: 特定カテゴリの変数を確認
# ------------------------------------------------------------------------------

cat("=== 政府統計カテゴリの変数一覧 ===\n")
govt_vars <- names(outcome_variables$government_statistics)
for (i in seq_along(govt_vars)) {
  cat(sprintf("%2d. %s\n", i, govt_vars[i]))
}
cat("\n")

# ------------------------------------------------------------------------------
# 例3: 特定の変数の詳細情報を表示
# ------------------------------------------------------------------------------

cat("=== 地域内総生産（GDP）の詳細 ===\n")
gdp_info <- outcome_variables$government_statistics$`地域内総生産（GDP）`
cat("英語名:", gdp_info$name, "\n")
cat("データソース:", gdp_info$source, "\n")
cat("単位:", gdp_info$unit, "\n")
cat("更新頻度:", gdp_info$frequency, "\n")
cat("\n")

# ------------------------------------------------------------------------------
# 例4: 地域特性変数の一覧を取得
# ------------------------------------------------------------------------------

cat("=== 地域特性変数のカテゴリ ===\n")
print(names(regional_characteristic_variables))
cat("\n")

# 各カテゴリの変数数を表示
cat("=== 各カテゴリの変数数 ===\n")
for (category in names(regional_characteristic_variables)) {
  count <- length(regional_characteristic_variables[[category]])
  cat(sprintf("%s: %d個\n", category, count))
}
cat("\n")

# ------------------------------------------------------------------------------
# 例5: 交通インフラ関連の変数を確認
# ------------------------------------------------------------------------------

cat("=== 交通インフラ関連の変数一覧 ===\n")
transport_vars <- names(regional_characteristic_variables$transportation)
for (i in seq_along(transport_vars)) {
  var_info <- regional_characteristic_variables$transportation[[transport_vars[i]]]
  cat(sprintf("%2d. %s (%s)\n", i, transport_vars[i], var_info$name))
}
cat("\n")

# ------------------------------------------------------------------------------
# 例6: データソースごとにアウトカム変数を整理
# ------------------------------------------------------------------------------

cat("=== データソース別のアウトカム変数（最初の5つ） ===\n")
sources <- list()
for (category in names(outcome_variables)) {
  for (var_name in names(outcome_variables[[category]])) {
    var_info <- outcome_variables[[category]][[var_name]]
    source <- var_info$source
    if (!source %in% names(sources)) {
      sources[[source]] <- c()
    }
    sources[[source]] <- c(sources[[source]], var_name)
  }
}

# 最初の5つのソースを表示
for (i in 1:min(5, length(sources))) {
  source_name <- names(sources)[i]
  cat(sprintf("\n【%s】\n", source_name))
  vars <- sources[[source_name]]
  for (j in seq_along(vars)) {
    cat(sprintf("  - %s\n", vars[j]))
  }
}
cat("\n")

# ------------------------------------------------------------------------------
# 例7: データ型別に地域特性変数を分類
# ------------------------------------------------------------------------------

cat("=== データ型別の地域特性変数数 ===\n")
types <- list()
for (category in names(regional_characteristic_variables)) {
  for (var_name in names(regional_characteristic_variables[[category]])) {
    var_info <- regional_characteristic_variables[[category]][[var_name]]
    if (!is.null(var_info$type)) {
      var_type <- var_info$type
      if (!var_type %in% names(types)) {
        types[[var_type]] <- 0
      }
      types[[var_type]] <- types[[var_type]] + 1
    }
  }
}

for (type_name in names(types)) {
  cat(sprintf("%s: %d個\n", type_name, types[[type_name]]))
}
cat("\n")

# ------------------------------------------------------------------------------
# 例8: メタデータの表示
# ------------------------------------------------------------------------------

cat("=== 変数定義メタデータ ===\n")
cat("作成日:", as.character(variable_metadata$created_date), "\n")
cat("バージョン:", variable_metadata$version, "\n")
cat("説明:", variable_metadata$description, "\n")
cat("アウトカム変数総数:", variable_metadata$outcome_variables_count, "\n")
cat("地域特性変数総数:", variable_metadata$regional_characteristic_variables_count, "\n")
cat("\n注意事項:\n")
for (note in variable_metadata$notes) {
  cat(sprintf("  - %s\n", note))
}
cat("\n")

# ------------------------------------------------------------------------------
# 例9: すべてのアウトカム変数名を一覧表示
# ------------------------------------------------------------------------------

cat("=== すべてのアウトカム変数名（最初の20個） ===\n")
all_outcome_names <- unlist(lapply(outcome_variables, names))
for (i in 1:min(20, length(all_outcome_names))) {
  cat(sprintf("%2d. %s\n", i, all_outcome_names[i]))
}
if (length(all_outcome_names) > 20) {
  cat(sprintf("... 他 %d個\n", length(all_outcome_names) - 20))
}
cat("\n総数:", length(all_outcome_names), "個\n\n")

# ------------------------------------------------------------------------------
# 例10: 独自指標の一覧表示
# ------------------------------------------------------------------------------

cat("=== 独自指標（計算が必要な指標） ===\n")
original_vars <- outcome_variables$original_indicators
for (i in seq_along(original_vars)) {
  var_name <- names(original_vars)[i]
  var_info <- original_vars[[var_name]]
  cat(sprintf("%2d. %s\n", i, var_name))
  cat(sprintf("    英語名: %s\n", var_info$name))
  cat(sprintf("    データソース: %s\n", var_info$source))
  if (!is.null(var_info$note)) {
    cat(sprintf("    備考: %s\n", var_info$note))
  }
  cat("\n")
}

cat("=== 実行完了 ===\n")
