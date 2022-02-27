all: show

ip:
	for d in $$(ls -d tgw-workload-?); do echo $$d: && terraform -chdir=$$d output; done

show:
	for d in $$(ls -d base-aws-network-? tgw-site-? tgw-workload-?); do echo $$d: && terraform -chdir=$$d show ; done

networks:
	for d in $$(ls -d base-aws-network-?); do echo $$d: && terraform -chdir=$$d apply --auto-approve; done

workloads:
	for d in $$(ls -d tgw-workload-?); do echo $$d: && terraform -chdir=$$d apply --auto-approve; done

