#!/bin/bash
#LF
# May 2019
# Transform VCF file to bed format

	# Put multiallelic lines separatly
	# Extract variant sites and allelic info 
	# Transform in bed format
vcf_file=$1
bed_file="${vcf_file%.vcf.gz}.bed"

echo "processing $vcf_file"
bcftools norm -m "-both" ${vcf_file} | bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%AF\n' | awk '{OFS="\t"; print "chr"$1, $2-1, $2, $3, $4, $5, $6, $7}' |sort -k1,1 -k2,2n > $bed_file


echo "done with $vcf_file"

