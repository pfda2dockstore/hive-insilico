# Generated by precisionFDA exporter (v1.0.3) on 2018-06-13 23:00:04 +0000
# The asset download links in this file are valid only for 24h.

# Exported app: hive-insilico, revision: 3, authored by: george.asimenos
# https://precision.fda.gov/apps/app-BkxQ6Y00G16XfjPzJkY8FvJv

# For more information please consult the app export section in the precisionFDA docs

# Start with Ubuntu 14.04 base image
FROM ubuntu:14.04

# Install default precisionFDA Ubuntu packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
	aria2 \
	byobu \
	cmake \
	cpanminus \
	curl \
	dstat \
	g++ \
	git \
	htop \
	libboost-all-dev \
	libcurl4-openssl-dev \
	libncurses5-dev \
	make \
	perl \
	pypy \
	python-dev \
	python-pip \
	r-base \
	ruby1.9.3 \
	wget \
	xz-utils

# Install default precisionFDA python packages
RUN pip install \
	requests==2.5.0 \
	futures==2.2.0 \
	setuptools==10.2

# Add DNAnexus repo to apt-get
RUN /bin/bash -c "echo 'deb http://dnanexus-apt-prod.s3.amazonaws.com/ubuntu trusty/amd64/' > /etc/apt/sources.list.d/dnanexus.list"
RUN /bin/bash -c "echo 'deb http://dnanexus-apt-prod.s3.amazonaws.com/ubuntu trusty/all/' >> /etc/apt/sources.list.d/dnanexus.list"
RUN curl https://wiki.dnanexus.com/images/files/ubuntu-signing-key.gpg | apt-key add -

# Update apt-get
RUN DEBIAN_FRONTEND=noninteractive apt-get update

# Download app assets
RUN curl https://dl.dnanex.us/F/D/zpBkPfzvxx1FZ0K70QjQgv3y5QyBpbKBKk6k1BX4/bcftools-1.2.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/gkq5F0jBX07Yzgx9yjjj1ZzF934jZBQB9z41jx06/bedtools-2.25.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/2B7VV0PXvyBZFx528Y7PZ4k57Gk9K8yKKGZfFVQB/bedtools-grch37.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/20kF4jY83Jzb7GKzjZQ22XF3pxjjg1VvV52g3z8b/hive-grch37.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/bQy30gBYkjpyyQ7jZFyxQ52XYxvkY82YQk02KzXB/hive-insilico-0.5.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/9jgqbQQgff8jgfJ1Jq7j1JJV0z2954KFG60yb5x8/htslib-1.2.1.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions

# Download helper executables
RUN curl https://dl.dnanex.us/F/D/0K8P4zZvjq9vQ6qV0b6QqY1z2zvfZ0QKQP4gjBXp/emit-1.0.tar.gz | tar xzf - -C /usr/bin/ --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/bByKQvv1F7BFP3xXPgYXZPZjkXj9V684VPz8gb7p/run-1.2.tar.gz | tar xzf - -C /usr/bin/ --no-same-owner --no-same-permissions

# Write app spec and code to root folder
RUN ["/bin/bash","-c","echo -E \\{\\\"spec\\\":\\{\\\"input_spec\\\":\\[\\{\\\"name\\\":\\\"variants\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Variants\\ VCF\\\",\\\"help\\\":\\\"A\\ VCF\\ file\\ with\\ the\\ variants\\ to\\ introduce\\ into\\ the\\ simulated\\ reads.\\\"\\},\\{\\\"name\\\":\\\"targets\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Targets\\ BED\\\",\\\"help\\\":\\\"A\\ BED\\ file\\ containing\\ genomic\\ regions\\ in\\ GRCh37\\ from\\ which\\ to\\ simulate\\ reads.\\\"\\},\\{\\\"name\\\":\\\"padding\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Padding\\ to\\ add\\ around\\ targets\\\",\\\"help\\\":\\\"\\(Optional\\)\\ The\\ number\\ of\\ bases\\ to\\ pad\\ each\\ target\\ interval,\\ to\\ aid\\ in\\ simulation\\ so\\ that\\ targets\\ are\\ not\\ smaller\\ than\\ the\\ read\\ length.\\\"\\},\\{\\\"name\\\":\\\"number_of_reads\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Number\\ of\\ reads\\\",\\\"help\\\":\\\"The\\ number\\ of\\ reads\\ \\(or\\ read\\ pairs,\\ if\\ paired-end\\ is\\ chosen\\)\\ to\\ generate.\\\",\\\"default\\\":1000000\\},\\{\\\"name\\\":\\\"read_length\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Read\\ length\\\",\\\"help\\\":\\\"The\\ read\\ length\\ to\\ simulate.\\ Regions\\ smaller\\ than\\ the\\ read\\ length\\ may\\ be\\ ignored.\\\",\\\"default\\\":75\\},\\{\\\"name\\\":\\\"noise\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Noise\\ \\(\\%\\)\\ to\\ simulate\\\",\\\"help\\\":\\\"\\(Optional\\)\\ The\\ amount\\ of\\ white\\ noise\\ to\\ simulate.\\ A\\ value\\ of\\ 1\\ means\\ that\\ 1\\%\\ of\\ white\\ noise\\ will\\ be\\ added.\\\"\\},\\{\\\"name\\\":\\\"paired_end\\\",\\\"class\\\":\\\"boolean\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Simulate\\ paired-end\\ reads\\?\\\",\\\"help\\\":\\\"Select\\ this\\ to\\ simulate\\ read\\ pairs\\ instead\\ of\\ single\\ reads.\\\",\\\"default\\\":true\\},\\{\\\"name\\\":\\\"min_paired_size\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Minimum\\ paired-end\\ fragment\\ size\\\",\\\"help\\\":\\\"The\\ lowest\\ paired-end\\ fragment\\ size\\ to\\ simulate,\\ applicable\\ only\\ when\\ paired-end\\ reads\\ are\\ simulated.\\\",\\\"default\\\":180\\},\\{\\\"name\\\":\\\"max_paired_size\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Maximum\\ paired-end\\ fragment\\ size\\\",\\\"help\\\":\\\"The\\ highest\\ paired-end\\ fragment\\ size\\ to\\ simulate,\\ applicable\\ only\\ when\\ paired-end\\ reads\\ are\\ simulated.\\\",\\\"default\\\":250\\},\\{\\\"name\\\":\\\"output_prefix\\\",\\\"class\\\":\\\"string\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Prefix\\ for\\ output\\ files\\\",\\\"help\\\":\\\"The\\ prefix\\ that\\ will\\ be\\ used\\ to\\ name\\ the\\ output\\ files.\\\"\\}\\],\\\"output_spec\\\":\\[\\{\\\"name\\\":\\\"fastq\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Simulated\\ FASTQ\\ file\\\",\\\"help\\\":\\\"The\\ gzipped\\ FASTQ\\ containing\\ the\\ reads\\ \\(or\\ first\\ mates,\\ for\\ paired-end\\).\\\"\\},\\{\\\"name\\\":\\\"fastq2\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Simulated\\ second\\ FASTQ\\ file\\ \\(for\\ paired-end\\)\\\",\\\"help\\\":\\\"The\\ gzipped\\ FASTQ\\ containing\\ the\\ second\\ mates,\\ for\\ paired-end.\\\"\\}\\],\\\"internet_access\\\":false,\\\"instance_type\\\":\\\"baseline-8\\\"\\},\\\"assets\\\":\\[\\\"file-Bk5K5yj0qVb8z3PVqx3V4p26\\\",\\\"file-Bk5K5yj0qVb1VgP6pVJPyv8p\\\",\\\"file-Bk5K5yj0qVb7ZjyyzjpB4F9b\\\",\\\"file-BkkXPbQ0qVb7YpjkFj4zqVJX\\\",\\\"file-BkkXQPj0qVbGy50f4b27Q2Px\\\",\\\"file-Bk5K5zQ0qVb7ZjyyzjpB4F9g\\\"\\],\\\"packages\\\":\\[\\]\\} \u003e /spec.json"]
RUN ["/bin/bash","-c","echo -E \\{\\\"code\\\":\\\"\\#\\ Set\\ HIVE\\ output\\ to\\ FASTQ\\\\ninsilico_opts\\=\\\\\\\"outformat\\=fastq\\\\u0026showId\\=1\\\\\\\"\\\\n\\\\nif\\ \\[\\[\\ \\\\\\\"\\$padding\\\\\\\"\\ \\!\\=\\ \\\\\\\"\\\\\\\"\\ \\]\\]\\;\\ then\\\\n\\ \\ \\#\\ Pad\\ BED\\ targets\\\\n\\ \\ bedtools\\ slop\\ -i\\ \\\\\\\"\\$targets_path\\\\\\\"\\ -g\\ grch37.chrsizes\\ -b\\ \\\\\\\"\\$padding\\\\\\\"\\ \\|\\ bedtools\\ merge\\ \\\\u003etargets.bed\\\\nelse\\\\n\\ \\ cp\\ \\\\\\\"\\$targets_path\\\\\\\"\\ targets.bed\\\\nfi\\\\n\\\\n\\#\\ Convert\\ the\\ BED\\ file\\ to\\ a\\ GTF\\ file\\\\nbed_to_gtf.py\\ \\\\u003c\\ targets.bed\\ \\\\u003e\\ targets.gtf\\\\n\\\\n\\#\\ Run\\ hive_ion\\ on\\ the\\ GTF\\;\\ this\\ makes\\ some\\ \\*.ion.\\*\\ files\\\\nhive_ion\\ -ionCreate\\ ion_targets\\ -gtfParse\\ targets.gtf\\\\n\\\\n\\#\\ Set\\ ion\\ files\\ for\\ HIVE\\\\ninsilico_opts\\=\\\\\\\"\\$insilico_opts\\\\\\\"\\\\\\\\\\\\u0026annotFile\\=ion_targets\\\\n\\\\n\\#\\ Set\\ number\\ of\\ reads\\\\ninsilico_opts\\=\\\\\\\"\\$insilico_opts\\\\\\\"\\\\\\\\\\\\u0026numReads\\=\\\\\\\"\\$number_of_reads\\\\\\\"\\\\n\\\\n\\#\\ Set\\ read\\ length\\\\ninsilico_opts\\=\\\\\\\"\\$insilico_opts\\\\\\\"\\\\\\\\\\\\u0026maxLen\\=\\\\\\\"\\$read_length\\\\\\\"\\\\ninsilico_opts\\=\\\\\\\"\\$insilico_opts\\\\\\\"\\\\\\\\\\\\u0026minLen\\=\\\\\\\"\\$read_length\\\\\\\"\\\\n\\\\n\\#\\ Set\\ paired-end\\ options\\\\nif\\ \\[\\[\\ \\\\\\\"\\$paired_end\\\\\\\"\\ \\=\\=\\ \\\\\\\"true\\\\\\\"\\ \\]\\]\\;\\ then\\\\n\\ \\ insilico_opts\\=\\\\\\\"\\$insilico_opts\\\\\\\"\\\\\\\\\\\\u0026pairedEnd\\=1\\\\n\\ \\ insilico_opts\\=\\\\\\\"\\$insilico_opts\\\\\\\"\\\\\\\\\\\\u0026pEndmin\\=\\\\\\\"\\$min_paired_size\\\\\\\"\\\\n\\ \\ insilico_opts\\=\\\\\\\"\\$insilico_opts\\\\\\\"\\\\\\\\\\\\u0026pEndmax\\=\\\\\\\"\\$max_paired_size\\\\\\\"\\\\nelse\\\\n\\ \\ insilico_opts\\=\\\\\\\"\\$insilico_opts\\\\\\\"\\\\\\\\\\\\u0026pairedEnd\\=0\\\\nfi\\\\n\\\\n\\#\\ Set\\ noise\\ options\\\\nif\\ \\[\\[\\ \\\\\\\"\\$noise\\\\\\\"\\ \\!\\=\\ \\\\\\\"\\\\\\\"\\ \\]\\]\\;\\ then\\\\n\\ \\ insilico_opts\\=\\\\\\\"\\$insilico_opts\\\\\\\"\\\\\\\\\\\\u0026noisePerc\\=\\\\\\\"\\$noise\\\\\\\"\\\\nfi\\\\n\\\\n\\#\\ Uncompress\\ VCF\\ file\\ if\\ needed\\\\nif\\ \\[\\[\\ \\$\\{variants_path:\\ -3\\}\\ \\=\\=\\ \\\\\\\".gz\\\\\\\"\\ \\]\\]\\;\\ then\\\\n\\ \\ zcat\\ \\\\\\\"\\$variants_path\\\\\\\"\\ \\\\u003e\\ variants.vcf\\\\nelse\\\\n\\ \\ mv\\ \\\\\\\"\\$variants_path\\\\\\\"\\ variants.vcf\\\\nfi\\\\n\\\\n\\#\\ Restrict\\ variants\\ to\\ the\\ unpadded\\ regions\\\\nbgzip\\ variants.vcf\\\\ntabix\\ -p\\ vcf\\ variants.vcf.gz\\\\nbcftools\\ view\\ -R\\ \\\\\\\"\\$targets_path\\\\\\\"\\ variants.vcf.gz\\ \\\\u003e\\ variants.vcf\\\\nrm\\ -f\\ variants.vcf.gz\\ variants.vcf.gz.tbi\\\\n\\\\n\\#\\ Set\\ variants\\\\ninsilico_opts\\=\\\\\\\"\\$insilico_opts\\\\\\\"\\\\\\\\\\\\u0026mutFile\\=variants.vcf\\\\n\\\\n\\#\\ Run\\ HIVE\\ Insilico\\\\nhive_insilico\\ -insilico\\ \\\\\\\"\\$insilico_opts\\\\\\\"\\ -vInsilico\\ grch37.vioseq2\\ \\\\\\\"\\$output_prefix\\\\\\\"\\\\n\\\\n\\#\\ Compress\\ and\\ emit\\ output\\ files\\\\nif\\ \\[\\[\\ \\\\\\\"\\$paired_end\\\\\\\"\\ \\=\\=\\ \\\\\\\"true\\\\\\\"\\ \\]\\]\\;\\ then\\\\n\\ \\ gzip\\ \\\\\\\"\\$output_prefix\\\\\\\"_1.fastq\\\\n\\ \\ emit\\ fastq\\ \\\\\\\"\\$output_prefix\\\\\\\"_1.fastq.gz\\\\n\\ \\ gzip\\ \\\\\\\"\\$output_prefix\\\\\\\"_2.fastq\\\\n\\ \\ emit\\ fastq2\\ \\\\\\\"\\$output_prefix\\\\\\\"_2.fastq.gz\\\\nelse\\\\n\\ \\ gzip\\ \\\\\\\"\\$output_prefix\\\\\\\".fastq\\\\n\\ \\ emit\\ fastq\\ \\\\\\\"\\$output_prefix\\\\\\\".fastq.gz\\\\nfi\\\\n\\\"\\} | python -c 'import sys,json; print json.load(sys.stdin)[\"code\"]' \u003e /script.sh"]

# Create directory /work and set it to $HOME and CWD
RUN mkdir -p /work
ENV HOME="/work"
WORKDIR /work

# Set entry point to container
ENTRYPOINT ["/usr/bin/run"]

VOLUME /data
VOLUME /work