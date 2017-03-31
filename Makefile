target: data/list.tsv

data/list.tsv:
	@mkdir -p data
	curl -s https://www.gov.uk/government/publications/list-of-authorised-isa-managers/isas-authorised-managers \
	| sed 's/<\/td>//g' \
	| awk 'NF' \
	| grep -A 4 '<tr>' \
	| grep -v '<th>' \
	| grep -v '<tr>' \
	| sed -E 's/<abbr title="limited liability partnership">LLP<\/abbr>/LLP/g' \
	| sed -E 's/<td>/|/g' \
	| tr '\n' ' ' \
	| sed -E 's/ *\|/\|/g' \
	| sed 's/--\|/~/g' \
	| tr '|' '\t' \
	| tr '~' '\n' \
	| sed -E 's/<abbr title="Individual Savings Account">ISA<\/abbr>/ISA/g' \
	| sed -E 's/<abbr title="public limited company">plc<\/abbr>/plc/g' \
	| awk 'NF' \
	> $@

data/companies.tsv: data/list.tsv ../gds/company-data/cache/companies.tsv
	bin/get_companies.sh 2 data/list.tsv ../gds/company-data/cache/companies.tsv \
	> $@
