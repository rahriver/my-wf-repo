process skesa {
    tag "$sample_id"
    publishDir "results/skesa", mode: 'copy'
    
    conda 'bioconda::skesa=2.4.0'

    input:
    tuple val(sample_id), path(r1), path(r2)

    output:
    tuple val(sample_id), path("contigs.fasta")

    script:
    """
    skesa \
      --fastq ${r1},${r2} \
      --contigs_out contigs.fasta \
      --cores 2
    """
}

