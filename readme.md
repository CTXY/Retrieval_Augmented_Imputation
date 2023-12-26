# RAI: Retrieval Augmented Imputation with Data Lakes
## Introduction
In this paper, we study retrieval augmented imputation (RAI), by searching candidate tuples that can help fill the missing values of tuples from a data lake. Offline, we systematically explore different methods of training tuple embeddings so as to effectively index tuples in a data lake using a vector database. Online, after retrieving top-$K$ tuples from the data lake using coarse-grained tuple embeddings, we further develop reranking algorithm to rerank retrieved tuples via a fine-grained value-by-value comparison, with the goal to use reranked top-$k$ tuples ($k \ll K$) for reasoning over tuples with missing values. Extensive experiments demonstrate that \sys can significantly improve the effectiveness of missing value imputation than just using LLMs, which sheds light on the direction of combining LLMs and data lakes for missing value imputation.

This repository contains the code for the paper **RAI: Retrieval Augmented Imputation with Data Lakes.**


## Data
We constructed five datasets focused on data imputation and pre-training data for the retriever. For an in-depth understanding of these datasets, please refer to our paper. The datasets are accessible via Google Drive: [Download Datasets](https://drive.google.com/file/d/1UFfE9GYtAjLLxaL2HzkpdqOfRIh7gXJv/view?usp=sharing). 
Additionally, the pretraining data is available at [this link](https://drive.google.com/file/d/1GXRSEP2MDLDG26raGS97FYKobQIyxvxC/view?usp=sharing)

Each dataset contains these files: **queries.tsv, qrels.tsv, collection.tsv, folds.json**

 - **queries.tsv**: Lists tuples with missing values denoted by "N/A", each identified by a unique ID.
 - **qrels.tsv**:  Contains query IDs, associated target tuple IDs, and their relevance scores.
 - **collection.tsv**: Each row contains a tuple ID and its corresponding full tuple text.
 - **folds.json**:  query IDs included in the train set and the test set respectively.
## Models

To facilitate ease of use, we offer a pretrained retriever model. You can download its checkpoint from [this link](https://drive.google.com/file/d/1_hFvY1SmqIVY3RZaotyr9Vm0EV7K4H79/view?usp=drive_link)  for direct application.

## Running Code
### Retrieval
To initiate the training of the retriever on your data, run the `train_siamese.sh` located in the retriever directory. Modify the `file_dir`  to point to the location of your pretraining data. Execute the code using the command below:
```powershell
./train_siamese.sh
```

Once the retriever is trained, you can build indexes for the tuples in your data lake and retrieve top-k tuples from the data lake. 你可以修改test_siamese.sh里面的参数来修改检索的tuples数量，指定数据集等。

```powershell
./test_siamese.sh
```
### Rerank
The reranker module is built based on Pygaggle. Before running the reranker, navigate to the reranker directory, clone the Pygaggle repository and installing the required environment:

```powershell
git clone https://github.com/castorini/pygaggle.git 
```
After that, move the run.sh, test.sh, train.sh, and test.py files from the reranker directory to the Pygaggle directory.

 1. To prepare the training data for the reranker, in the `./reranker/data` directory, run **build_training_data.py**  and specify name of dataset and file that stores results from the retriever. For example,
 ```powershell
python build_training_data.py  --dataset_name 'wikituples'  --retrieval_file '../../results/retrieval/wikituples_retrieval_results.tsv'
```
 
 3. specify name of dataset and the file storing the first-stage retrieval results in the `./reranker/data` directory
 
 4. For fine-tuning the reranker:
```powershell
./run.sh
```
 
 4. To rerank results obtained from the retriever:
```powershell
./test.sh
```
### Data Imputation

You can refer to the *.ipynb* file in the Imputation, which contains the code of data imputatoin with or without retrieved tuples and evaluation.

## Installation 
We will continue to update more detailed instructions and code in the future.

