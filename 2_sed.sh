sed 'n;n;N;d' 2_out/tmp.fastq | awk 'BEGIN {FS = "[;=]"} {if (/^@/) {printf "%s\t%s\t", $1, $3} else {print length($1)}}' | tr -d "@" >> 2_reports/step2.qual
