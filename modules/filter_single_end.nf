// Process: filter out single-end samples and warn
process FILTER_SINGLE_END {
    tag "filter_single_end"

    input:
        path design_file

    output:
        path 'cleaned_samplesheet.csv', emit: samplesheet

    script:
    """
    # Warn for single-end entries (missing R2)
    awk -F',' 'NR>1 && \$3 == "" { print "WARNING: Skipping single-end sample: " \$1 }' ${design_file} >&2
    # Keep only header + paired-end rows
    awk -F',' 'NR==1 || \$3 != "" { print }' ${design_file} > cleaned_samplesheet.csv
    """
}