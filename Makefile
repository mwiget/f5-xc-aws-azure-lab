all: ip

ip:
	@for d in $$(ls -d tgw-workload-?); do echo ""; echo $$d: && terraform -chdir=$$d output; done
	@echo ""
	@./list-sites.sh

show:
	for d in $$(ls -d base-aws-peering base-aws-network-? tgw-site-? tgw-workload-?); do echo $$d: && terraform -chdir=$$d show ; done

networks:
	for d in $$(ls -d base-aws-network-?); do echo $$d: && terraform -chdir=$$d apply --auto-approve; done

workloads:
	for d in $$(ls -d tgw-workload-?); do echo $$d: && terraform -chdir=$$d apply --auto-approve; done

apply:
	terraform -chdir=base-aws-network-1 apply --auto-approve
	terraform -chdir=base-aws-network-2 apply --auto-approve
	terraform -chdir=base-aws-peering apply --auto-approve
	terraform -chdir=tgw-site-1 apply --auto-approve
	terraform -chdir=tgw-site-2 apply --auto-approve
	terraform -chdir=tgw-workload-1 apply --auto-approve
	terraform -chdir=tgw-workload-2 apply --auto-approve

destroy:
	terraform -chdir=tgw-site-1 destroy --auto-approve
	terraform -chdir=tgw-site-2 destroy --auto-approve
	terraform -chdir=tgw-workload-1 destroy --auto-approve
	terraform -chdir=tgw-workload-2 destroy --auto-approve
	terraform -chdir=base-aws-peering destroy --auto-approve
	terraform -chdir=base-aws-network-2 destroy --auto-approve
	terraform -chdir=base-aws-network-1 destroy --auto-approve
