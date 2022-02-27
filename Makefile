all: show

show:
	for d in $$(ls -d base-aws-network-? tgw-site-? tgw-workload-?); do echo $$d: && terraform -chdir=$$d show ; done

