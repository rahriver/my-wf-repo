process fastp {
    tag "$sample_id"
    publishDir "results/fastp", mode: 'copy'

    conda 'bioconda::fastp=0.23.2'

    input:
    tuple val(sample_id), path(reads)

    output:
    tuple val(sample_id), path("${sample_id}_R1.trimmed.fastq.gz"), path("${sample_id}_R2.trimmed.fastq.gz")

    script:
    """
    fastp \
      -i ${reads[0]} -I ${reads[1]} \
      -o ${sample_id}_R1.trimmed.fastq.gz \
      -O ${sample_id}_R2.trimmed.fastq.gz \
      --detect_adapter_for_pe \
      --thread 2
    """
}
