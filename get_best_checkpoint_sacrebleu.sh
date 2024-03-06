#!/bin/bash
#get sacrebleu of best checkpoint predictions against ground truth (for each data split)

if [ $# -ne 10 ]; then
    echo "Mismatch in # of arguments provided"
    echo "Please provide -n model_unique_identifier_name ; -d model_unique_description; -is_train 1/0; -is_valid 1/0; -is_test 1/0;"
    exit 1
fi

while getopts n:d:is_train:is_valid:is_test: flag
do
    case "${flag}" in
        n) model_folder_name=${OPTARG};;
        d) model_desc=${OPTARG};;
        is_train) is_train=${OPTARG};;
        is_valid) is_valid=${OPTARG};;
        is_test) is_test=${OPTARG};;
    esac
done

if [ $is_train -ne 1 ]; then
    echo "Train BLEU score"
    fairseq-score -s output_custom_fldr/$model_folder_name/$model_desc/output_train_pred.txt -r output_custom_fldr/$model_folder_name/$model_desc/output_train_truth.txt -o 4 --sacrebleu
    echo ""
fi

if [ $is_valid -ne 1 ]; then
    echo "Valid BLEU score"
    fairseq-score -s output_custom_fldr/$model_folder_name/$model_desc/output_valid_pred.txt -r output_custom_fldr/$model_folder_name/$model_desc/output_valid_truth.txt -o 4 --sacrebleu
    echo ""
fi

if [ $is_test -ne 1 ]; then
    echo "Test BLEU score"
    fairseq-score -s output_custom_fldr/$model_folder_name/$model_desc/output_test_pred.txt -r output_custom_fldr/$model_folder_name/$model_desc/output_test_truth.txt -o 4 --sacrebleu
fi
