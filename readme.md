# RAI: Retrieval Augmented Imputation with Data Lakes
## Introduction
In this paper, we study retrieval augmented imputation (**RAI**), by searching candidate tuples that can help fill the missing values of tuples from a data lake. Offline, we systematically explore different methods of training tuple embeddings so as to effectively index tuples in a data lake using a vector database. Online, after retrieving top-K tuples from the data lake using coarse-grained tuple embeddings, we further develop reranking algorithm to rerank retrieved tuples via a fine-grained value-by-value comparison, with the goal to use reranked top-k tuples ($k \ll K$) for reasoning over tuples with missing values. Extensive experiments demonstrate that RAI can significantly improve the effectiveness of missing value imputation than just using LLMs, which sheds light on the direction of combining LLMs and data lakes for missing value imputation.

This repository contains the data and code for our paper **RAI: Retrieval Augmented Imputation with Data Lakes.**


## mvBench
To facilitate the research in retrieval-augmented missing value imputation, we release the first large-scale benchmark, **mvBench**, containing 15, 143 incomplete tuples and 4.23 million tuples from the data lake. Detailed descriptions and analyses of these datasets are provided in our paper. Also, we release pretraining data for retriever we constructed for further research. The datasets can be accessed through the following Google Drive links:
- [Five Datasets for Data Imputation](https://drive.google.com/file/d/1UFfE9GYtAjLLxaL2HzkpdqOfRIh7gXJv/view?usp=sharing)
- [Pretraining Data for our Retriever](https://drive.google.com/file/d/1GXRSEP2MDLDG26raGS97FYKobQIyxvxC/view?usp=sharing)

Each dataset on Data Imputation contains these files: **queries.tsv, qrels.tsv, collection.tsv, folds.json**

 - **queries.tsv**: Lists tuples with missing values denoted by "N/A", each identified by a unique ID.
 - **qrels.tsv**:  Contains query IDs, associated target tuple IDs, and their relevance scores.
 - **collection.tsv**: Each row contains a tuple ID and its corresponding complete tuple text.
 - **folds.json**:  query IDs included in the train set and the test set respectively.

## Models

To facilitate ease of use, we provide our pretrained retriever model. You can download its checkpoint from [this link](https://drive.google.com/file/d/1_hFvY1SmqIVY3RZaotyr9Vm0EV7K4H79/view?usp=drive_link) for immediate use.

## Running Code
### Retrieval
Execute the following steps to train the retriever on your dataset:
1. Navigate to the retriever directory and modify the `train_siamese.sh` script, setting `file_dir` to your pretraining data location.
2. Run the script using the command:
   ```powershell
   ./train_siamese.sh
   ```

After training, use the `test_siamese.sh` script to build indexes for tuples and retrieve the top-k tuples. Adjust num_retrieved and the dataset for indexing as required, then execute:
```powershell
./test_siamese.sh
```

### Rerank
The reranker module leverages Pygaggle, a gaggle of deep neural architectures for text ranking and question answering. Follow these steps:

1. In the reranker directory, clone the Pygaggle repository and set up the required environment:
```powershell
git clone https://github.com/castorini/pygaggle.git 
```

2. Transfer `run.sh`, `test.sh`, `train.py`, and `test.py` from the reranker directory to Pygaggle.

3. Prepare training data for the reranker by running build_training_data.py in the ./reranker/data directory. Specify the dataset and retrieval results file, for example:
```powershell
python build_training_data.py  --dataset_name 'wikituples'  --retrieval_file '../../results/retrieval/wikituples_retrieval_results.tsv'
```

4. Fine-tune the reranker using:
```powershell
./run.sh
```

5. Rerank the retrieval results:
```powershell
./test.sh
```
### Data Imputation

The Imputation directory contains Jupyter notebooks (*.ipynb*) with code and evaluation for data imputation, both with and without the use of retrieved tuples.

## Installation 
Detailed instructions and additional code updates will be provided progressively. 

