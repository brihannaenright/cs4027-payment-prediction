# Card or cash? Predicting how a NYC yellow-taxi trip is paid

CS4207 group project. A classifier that predicts whether a yellow-taxi trip is paid by **card** (`payment_type` 1) or **cash** (`payment_type` 2), using data and task parallelism.

## What's in here

| Path                             | What it is                                                                 |
| -------------------------------- | -------------------------------------------------------------------------- |
| `notebooks/taxipay_pipeline.ipynb` | The project. Sections 0 to 4, one owner each                             |
| `requirements.txt`               | The libraries the notebook needs                                           |
| `scripts/`                       | Two scripts for running the notebook on Rockhill                           |
| `data/`, `prepared/`, `results/` | Created when the notebook runs (`data/` and `prepared/` are not committed) |

## Decisions

- **Data**: yellow taxi, 2026. Rockhill has January to September in `/home/cs4207/data`. Other months are downloaded from the TLC site.
- **Split by time**: train Jan to Jun, validate Jul, test Aug and Sep.
- **Sampling**: Rockhill keeps 5% of each month. The laptop check keeps 2%, training on January, validating on February and testing on March.
- **Label**: `is_cash` = 1 for cash, 0 for card. Other payment codes are dropped. Cash is the minority class, so we report precision, recall, F1 and PR-AUC for cash, not just accuracy.
- **Leakage**: `tip_amount` and `total_amount` are never used. The data records card tips automatically, while tips for cash aren't. This would end up telling our model the answer.

## Setting up the environment

1. **Clone and install:**
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```

Open `notebooks/taxipay_pipeline.ipynb`, select your Python environment, then restart the kernel and run all cells. Start the kernel from the repository root or a folder inside it.

The notebook saves downloads to the repository-root `data/` folder, cleaned and feature tables to `prepared/`, and reports and plots to `results/`. It also reuses existing downloads in `notebooks/data/`. Section 0 prints the environment and configuration and saves them to `results/00_run_info.json`.

On Rockhill, run `bash scripts/run_notebook.sh` from the repository root to save the executed notebook and HTML report in `results/`.
