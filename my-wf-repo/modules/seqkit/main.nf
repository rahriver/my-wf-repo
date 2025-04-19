process seqkit_stats {
    tag "$sample_id"
    publishDir "results/seqkit", mode: 'copy'

    conda 'bioconda::seqkit=2.3.0'

    input:
    tuple val(sample_id), path(r1), path(r2)

    output:
    tuple val(sample_id), path("stats.tsv")

    script:
    """
    seqkit stats --all ${r1} ${r2} > stats.tsv
    """
}
