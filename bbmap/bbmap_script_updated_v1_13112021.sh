#! /usr/bin/env bash
in_R1=$1
in_R2=$2
extn=$3
out=$4

bbduk.sh -Xmx3g -Xms1g \
    in1=$in_R1 \
    in2=$in_R2 \
    outm1=$4/${in_R1/\.$extn/"_f0."$extn} \
    outm2=$4/${in_R2/\.$extn/"_f0."$extn} \
    k=22 mm=f rcomp=f restrictleft=30 skipr1=t \
    hdist=2 \
    stats=$4/${in_R1/.$extn/}_stats.pcr.txt \
    threads=30 \
    literal=CAAGCGTTGGCTTCTCGCATCT overwrite=TRUE

bbduk.sh -Xmx30g -Xms1g \
    in1=$4/${in_R1/\.$extn/"_f0."$extn} \
    in2=$4/${in_R2/\.$extn/"_f0."$extn} \
    outm1=$4/${in_R1/\.$extn/}_R1_filtered.fq.gz \
    outm2=$4/${in_R2/\.$extn/}_R2_filtered.fq.gz \
    k=30 mm=f rcomp=f restrictleft=70 skipr1=t \
    hdist=3 stats=$4/${in_R1/\.$extn/}_stats.txt threads=30 minlen=80 \
    literal=ATCCACGTGCTTGAGAGGCCAGAGCATTCG overwrite=TRUE
