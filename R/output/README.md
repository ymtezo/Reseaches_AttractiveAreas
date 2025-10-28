# Output Directory

このディレクトリには分析結果と可視化図表が保存されます。

## 自動生成されるファイル

スクリプト実行時に以下のファイルが自動生成されます：

### CSVファイル
- `factor_importance_ranking.csv` - 因子重要度ランキング

### 画像ファイル（PNG）
- `outcome_correlation_plot.png` - アウトカム指標の相関マトリクス
- `outcome_pca_biplot.png` - PCAバイプロット
- `rf_importance_*.png` - ランダムフォレストによる変数重要度
- `outcome_distributions.png` - アウトカム指標の分布
- `success_level_comparison.png` - 成功レベル別比較
- `factor_importance_ranking.png` - 因子影響度ランキング図
- `factor_outcome_relationships.png` - 因子とアウトカムの関係図

これらのファイルは `.gitignore` に含まれており、Gitで追跡されません。
