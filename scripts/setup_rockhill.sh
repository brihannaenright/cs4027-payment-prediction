#!/usr/bin/env bash
# One-time setup on Rockhill. Run from the project folder:  bash scripts/setup_rockhill.sh
# Safe to run again: it only adds what is missing.
set -euo pipefail
cd "$(dirname "$0")/.."

if [ ! -d ~/venv ]; then
    echo "Creating ~/venv (the same environment as the labs)"
    python3 -m venv ~/venv
fi
source ~/venv/bin/activate
pip install --quiet --upgrade pip
pip install --quiet -r requirements.txt
echo "Libraries installed into ~/venv"

if ls /home/cs4207/data/yellow_tripdata_*.parquet >/dev/null 2>&1; then
    echo "Taxi data found in /home/cs4207/data:"
    ls /home/cs4207/data/yellow_tripdata_*.parquet | xargs -n1 basename
else
    echo "WARNING: no taxi files in /home/cs4207/data. Ask on the module forum, or copy files into data/"
fi
mkdir -p logs prepared results
echo "Done. Next: bash scripts/run_notebook.sh"
