python impute_w_confidence.py \
    --thresholds 0.7 0.8 0.9 1.0 \
    --model gpt-4o \
    --api_key "sk-pP1nu21e5A9Ucg9bB82c0dC07d334b9aA7A0Bc26F3Eb2f72" \
    --retrieval_results_path "/home/yangchenyu/Data_Imputation/Reranker/results/final/generated_show_movie_pretrained_epoch20_lr_5e-5.test.scores.txt"  \
    --collection_path "/home/yangchenyu/Data_Imputation/data/show_movie/annotated_data/collection.tsv" \
    --folds_path "/home/yangchenyu/Data_Imputation/data/show_movie/annotated_data/folds.json" \
    --output_path "/home/yangchenyu/Data_Imputation/imputation/results/show_movie/gpt-4o_show_movie_evidence_confidence_reranker_top5.jsonl" \
    --top_k 5 \
    --num_threads 8