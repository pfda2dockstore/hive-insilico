baseCommand: []
class: CommandLineTool
cwlVersion: v1.0
id: hive-insilico
inputs:
  max_paired_size:
    default: 250
    doc: The highest paired-end fragment size to simulate, applicable only when paired-end
      reads are simulated.
    inputBinding:
      position: 9
      prefix: --max_paired_size
    type: long?
  min_paired_size:
    default: 180
    doc: The lowest paired-end fragment size to simulate, applicable only when paired-end
      reads are simulated.
    inputBinding:
      position: 8
      prefix: --min_paired_size
    type: long?
  noise:
    doc: (Optional) The amount of white noise to simulate. A value of 1 means that
      1% of white noise will be added.
    inputBinding:
      position: 6
      prefix: --noise
    type: long?
  number_of_reads:
    default: 1000000
    doc: The number of reads (or read pairs, if paired-end is chosen) to generate.
    inputBinding:
      position: 4
      prefix: --number_of_reads
    type: long
  output_prefix:
    doc: The prefix that will be used to name the output files.
    inputBinding:
      position: 10
      prefix: --output_prefix
    type: string
  padding:
    doc: (Optional) The number of bases to pad each target interval, to aid in simulation
      so that targets are not smaller than the read length.
    inputBinding:
      position: 3
      prefix: --padding
    type: long?
  paired_end:
    default: true
    doc: Select this to simulate read pairs instead of single reads.
    inputBinding:
      position: 7
      prefix: --paired_end
    type: boolean
  read_length:
    default: 75
    doc: The read length to simulate. Regions smaller than the read length may be
      ignored.
    inputBinding:
      position: 5
      prefix: --read_length
    type: long
  targets:
    doc: A BED file containing genomic regions in GRCh37 from which to simulate reads.
    inputBinding:
      position: 2
      prefix: --targets
    type: File
  variants:
    doc: A VCF file with the variants to introduce into the simulated reads.
    inputBinding:
      position: 1
      prefix: --variants
    type: File
label: HIVE Insilico | Simulate GRCh37 reads from BED and VCF
outputs:
  fastq:
    doc: The gzipped FASTQ containing the reads (or first mates, for paired-end).
    outputBinding:
      glob: fastq/*
    type: File
  fastq2:
    doc: The gzipped FASTQ containing the second mates, for paired-end.
    outputBinding:
      glob: fastq2/*
    type: File
requirements:
- class: DockerRequirement
  dockerOutputDirectory: /data/out
  dockerPull: pfda2dockstore/hive-insilico:3
s:author:
  class: s:Person
  s:name: George Asimenos
