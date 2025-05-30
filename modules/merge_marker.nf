process MERGE_MARKER_MAP {
    tag "Combine Marker Maps"
    
    publishDir "${params.outdir}", mode: 'copy', overwrite: true

    input:
    val stats_files

    output:
    path 'all_marker_map.tsv'

    script:
    def uniqueFiles = stats_files.unique()
    def fileList    = uniqueFiles.join(' ')
    def first       = uniqueFiles[0]

    """
    head -n1 ${first} > all_marker_map.tsv

    for f in ${fileList}; do
      tail -n +2 "\$f" >> all_marker_map.tsv
    done
    
    sort all_marker_map.tsv | uniq > tmp.tsv && mv tmp.tsv all_marker_map.tsv
    """
}
