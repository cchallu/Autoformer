from pathlib import Path
import logging

import pandas as pd


logging.basicConfig(level=logging.INFO)

results = Path('./results')
for dataset in ['ETTh1', 'ETTh2', 'ETTm1', 'ETTm2', 'ECL', 'Exchange', 'ili', 'traffic', 'weather']:
    for kind in ['M', 'S']:
        logging.info(f'Dataset: {dataset}, kind: {kind}')
        files_y = list(results.glob(f'{dataset}_*ft{kind}*/df_y.csv'))
        files_x = list(results.glob(f'{dataset}_*ft{kind}*/df_x.csv'))

        if not files_y:
            logging.info('No files detected\n')
            continue

        logging.info('Files detected')

        df_y = [pd.read_csv(file_) for file_ in files_y]
        df_x = [pd.read_csv(file_) for file_ in files_x]

        assert all(df.equals(df_y[0]) for df in df_y), f'Distinct DFs y for {dataset}'
        assert all(df.equals(df_x[0]) for df in df_x), f'Distinct DFs x for {dataset}'

        assert not df_y[0].isnull().values.any(), f'Missing values y for {dataset}'
        assert not df_x[0].isnull().values.any(), f'Missing values x for {dataset}'

        assert not df_y[0].empty, f'Empty dataframe y for {dataset}'
        assert not df_x[0].empty, f'Empty dataframe x for {dataset}'

        results_dataset = results / '1-clean' / dataset / kind
        results_dataset.mkdir(parents=True, exist_ok=True)

        df_y[0].to_csv(results_dataset / 'df_y.csv', index=False)
        df_x[0].to_csv(results_dataset / 'df_x.csv', index=False)

        n_series = df_y[0]['unique_id'].unique().shape[0]
        n_obs = df_y[0]['ds'].unique().shape[0]

        logging.info(f'n_series: {n_series}, n_obs: {n_obs}\n')
