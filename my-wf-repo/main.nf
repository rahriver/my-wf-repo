#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

// Import DSL2 modules
include { fastp }       from './modules/fastp/main.nf'
include { skesa }       from './modules/skesa/main.nf'
include { seqkit_stats } from './modules/seqkit/main.nf'

workflow {

    Channel
        .fromFilePairs(params.reads, fileExtension: '.fastq.gz')
        .map { sample, files -> tuple(sample, files) }
        .set { read_pairs }

    trimmed = fastp(read_pairs)

    assembled = skesa(trimmed)
    stats     = seqkit_stats(trimmed)

    assembled.view()
    stats.view()
}

