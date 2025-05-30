process SAMPLESHEET_CHECK {
    tag "$samplesheet"

    container 'docker.io/namlhs/io-gmwi2-pipeline:5.25'

    input:
    path samplesheet

    output:
    path '*samplesheet.valid.csv'       , emit: csv
    path '*group_metadata.csv'          , emit: grouping
    path "versions.yml", emit: versions
    
    when:
    task.ext.when == null || task.ext.when

    script: 
    """
    check_samplesheet.py \\
        $samplesheet \\
        samplesheet.valid.csv

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        python: \$(python --version | sed 's/Python //g')
    END_VERSIONS
    """
}
