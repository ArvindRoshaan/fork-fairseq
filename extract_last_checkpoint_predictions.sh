#!/bin/bash
#create files containing ground truth and predictions of the last checkpoint (for each data split)

if [ $# -ne 14 ]; then
    echo "Mismatch in # of arguments provided"
    echo "Please provide -n model_unique_identifier_name ; -d model_unique_description; -s source_lang; -t target_lang; -is_train 1/0; -is_valid 1/0; -is_test 1/0;"
    exit 1
fi

while getopts n:d:s:t:is_train:is_valid:is_test: flag
do
    case "${flag}" in
        n) model_folder_name=${OPTARG};;
        d) model_desc=${OPTARG};;
	    s) source_lang=${OPTARG};;
	    t) target_lang=${OPTARG};;
        is_train) is_train=${OPTARG};;
        is_valid) is_valid=${OPTARG};;
        is_test) is_test=${OPTARG};;
    esac
done

lang=$source_lang-$target_lang

if [ $is_train -ne 1 ]; then
    echo "Extracting training text"
    grep "H-" output_custom_fldr/$model_folder_name/$model_desc/output_train_lastCP_$lang.txt | cut -f 3 > output_custom_fldr/$model_folder_name/$model_desc/output_train_lastCP_pred.txt
    grep "T-" output_custom_fldr/$model_folder_name/$model_desc/output_train_lastCP_$lang.txt | cut -f 2 > output_custom_fldr/$model_folder_name/$model_desc/output_train_lastCP_truth.txt
    echo "no of lines in output_train_lastCP_pred is"
    wc -l output_custom_fldr/$model_folder_name/$model_desc/output_train_lastCP_pred.txt
    echo "no of lines in output_train_lastCP_truth is"
    wc -l output_custom_fldr/$model_folder_name/$model_desc/output_train_lastCP_truth.txt
fi

if [ $is_valid -ne 1 ]; then
    echo "Extracting validation text"
    grep "H-" output_custom_fldr/$model_folder_name/$model_desc/output_valid_lastCP_$lang.txt | cut -f 3 > output_custom_fldr/$model_folder_name/$model_desc/output_valid_lastCP_pred.txt
    grep "T-" output_custom_fldr/$model_folder_name/$model_desc/output_valid_lastCP_$lang.txt | cut -f 2 > output_custom_fldr/$model_folder_name/$model_desc/output_valid_lastCP_truth.txt
    echo "no of lines in output_valid_lastCP_pred is"
    wc -l output_custom_fldr/$model_folder_name/$model_desc/output_valid_lastCP_pred.txt
    echo "no of lines in output_valid_lastCP_truth is"
    wc -l output_custom_fldr/$model_folder_name/$model_desc/output_valid_lastCP_truth.txt
fi

if [ $is_test -ne 1 ]; then
    echo "Extracting test text"
    grep "H-" output_custom_fldr/$model_folder_name/$model_desc/output_test_lastCP_$lang.txt | cut -f 3 > output_custom_fldr/$model_folder_name/$model_desc/output_test_lastCP_pred.txt
    grep "T-" output_custom_fldr/$model_folder_name/$model_desc/output_test_lastCP_$lang.txt | cut -f 2 > output_custom_fldr/$model_folder_name/$model_desc/output_test_lastCP_truth.txt
    echo "no of lines in output_test_lastCP_pred is"
    wc -l output_custom_fldr/$model_folder_name/$model_desc/output_test_lastCP_pred.txt
    echo "no of lines in output_test_lastCP_truth is"
    wc -l output_custom_fldr/$model_folder_name/$model_desc/output_test_lastCP_truth.txt
fi
