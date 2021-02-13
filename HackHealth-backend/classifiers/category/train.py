import numpy as np
import pandas as pd
from simpletransformers.classification import ClassificationModel

train_df = pd.read_csv("data/train.csv")
test_df = pd.read_csv("data/test.csv")

df = pd.DataFrame()
df['text'] = train_df['Description']
df['label'] = train_df['Class Index']

df['label'] = df['label'].apply(lambda x: x - 1)
df['label'].value_counts()

model = ClassificationModel('bert', 'bert-base-cased', num_labels=4,
                            args={'reprocess_input_data': True, 'overwrite_output_dir': True}, use_cuda=True)

model.train_model(df)

model.predict(["Indians Mount Charge. The Cleveland Indians pulled within one game of the AL Central lead by beating the Minnesota Twins, 7-1, Saturday night with home runs by Travis Hafner and Victor Martinez."])