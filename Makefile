.DEFAULT_GOAL := all


all: submodules tar upload clean

submodules:
	@git submodule update --init

tar:
	@echo "INFO: creating diaco-cookbooks.tar.gz"
	@tar --exclude=.git --exclude=diaco-cookbooks.tar.gz -czf diaco-cookbooks.tar.gz .

clean:
	@[ -f diaco-cookbooks.tar.gz ] && rm diaco-cookbooks.tar.gz || true

upload: tar
	@aws s3 cp diaco-cookbooks.tar.gz s3://diaco-opsworks-cookbooks/diaco-cookbooks.tar.gz \
		--grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers \
		--profile diaco 
