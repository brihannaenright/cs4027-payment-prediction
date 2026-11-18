#!/usr/bin/env bash
# Rockhill only. Runs the notebook from start to finish and saves two copies WITH all
# outputs in results/:
#   taxipay_pipeline_executed.ipynb   the run with outputs (the version to submit)
#   taxipay_pipeline.html             the same, to open in any browser
# The notebook you edit is left unchanged.
#
#   bash scripts/run_notebook.sh
#
# For a long run, keep it going after you log out:
#   nohup bash scripts/run_notebook.sh > logs/run.out 2>&1 &
#   tail -f logs/run.out          # watch it (Ctrl+C stops watching, not the run)
set -euo pipefail
cd "$(dirname "$0")/.."
source ~/venv/bin/activate
mkdir -p logs results

nb="${1:-notebooks/taxipay_pipeline.ipynb}"
log="logs/run_$(date +%Y%m%d-%H%M%S).log"
echo "$(date +%H:%M:%S)  running $nb   (log: $log)"
start=$SECONDS
if jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 \
        --output taxipay_pipeline_executed --output-dir results "$nb" > "$log" 2>&1; then
    jupyter nbconvert --to html results/taxipay_pipeline_executed.ipynb \
        --output taxipay_pipeline --output-dir results >> "$log" 2>&1
    echo "$(date +%H:%M:%S)  finished in $((SECONDS - start)) s"
    echo "          results/taxipay_pipeline_executed.ipynb and results/taxipay_pipeline.html"
else
    echo "$(date +%H:%M:%S)  FAILED: the error is at the end of $log"
    tail -n 20 "$log"
    exit 1
fi
