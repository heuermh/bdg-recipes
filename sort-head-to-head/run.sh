#! /bin/bash
#
# Licensed to Big Data Genomics (BDG) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The BDG licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -x

export ADAM_DRIVER_MEMORY="200g"
export ADAM_EXECUTOR_MEMORY="200g"
export SPARK_HOME="/home/ubuntu/spark-1.2.1-bin-hadoop2.4"
export ADAM_HOME="/home/ubuntu/adam"

cd /mnt2/

# pull NA12878 from 1000g
~/s3cmd/s3cmd get \
    --secret_key=${SECRET_KEY} \
    --access_key=${ACCESS_KEY} \
    s3://1000genomes/data/NA12878/high_coverage_alignment/NA12878.mapped.ILLUMINA.bwa.CEU.high_coverage_pcr_free.20130906.bam
mv NA12878.mapped.ILLUMINA.bwa.CEU.high_coverage_pcr_free.20130906.bam NA12878.bam

cd ~

# index bam file
samtools index /mnt2/NA12878.bam

# sort reads in picard
time java -Xmx200g \
    -jar ~/picard/dist/picard.jar \
    SortSam \
    INPUT=/mnt2/NA12878.bam \
    OUTPUT=/mnt2/NA12878.sorted.bam \
    SORT_ORDER=coordinate
rm -r /mnt2/NA12878.sorted.bam

# convert to adam
${ADAM_HOME}/bin/adam-submit transform \
    /mnt2/NA12878.bam \
    /mnt2/NA12878.adam

# sort using adam
time ${ADAM_HOME}/bin/adam-submit transform \
    /mnt2/NA12878.adam \
    /mnt2/NA12878.sorted.adam \
    -sort_reads
rm -r /mnt2/NA12878*.adam

# sort using samtools
time samtools sort \
    /mnt2/NA12878.bam \
    /mnt2/NA12878.sorted \
    -@ 32
rm -r /mnt2/NA12878.sorted*

# sort using sambamba
time ~/sambamba sort \
    /mnt2/NA12878.bam \
    /mnt2/NA12878.sorted \
    -t32
rm -r /mnt2/NA12878.sorted*
