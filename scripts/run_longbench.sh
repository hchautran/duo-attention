#!/bin/bash
#SBATCH -c 4 # request two cores 
#SBATCH -o /netscratch/duynguyen/Research/duo-attention/logs/longbench.out
#SBATCH -e /netscratch/duynguyen/Research/duo-attention/logs/longbench_error.out
#SBATCH -p A100-IML 
#SBATCH --mem-per-cpu 64G
#SBATCH --time=1-00:00
#SBATCH --job-name=longbench
#SBATCH --ntasks 1
#SBATCH --gpus-per-task=2 


attn_pattern_name="lr=0.02-reg=0.05-ctx=1000_32000-multi_passkey10"
models="Llama-2-7B-32K-Instruct Llama-3-8B-Instruct-Gradient-1048k"

sparsities="0.75 0.5 0.0"

tasks="samsum narrativeqa qasper triviaqa hotpotqa multifieldqa_en multifieldqa_zh 2wikimqa musique dureader gov_report qmsum multi_news vcsum trec lsht passage_count passage_retrieval_en passage_retrieval_zh lcc repobench-p"

for model in $models; do
    for task in $tasks; do
        for sparsity in $sparsities; do
            bash scripts/longbench.sh $model $task "attn_patterns/${model}/${attn_pattern_name}" $sparsity
        done
    done
done

cd eval/LongBench
for model in $models; do
    python -u eval.py --model $model &
done
