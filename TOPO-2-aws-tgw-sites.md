# 2 AWS TGW Sites Topology

## VPC and IP addresses

```
marcel-aws-tgw-site-1:

       ------- Service VPC (100.64.0.0/20) ------   ------ Spoke VPC (10.0.0.0/20) ---------

       external        internal       workload        external      internal      workload
az1 100.64.0.0/24   100.64.1.0/24   100.64.2.0/24   10.0.0.0/24   10.0.1.0/24   10.0.2.0/24
az2 100.64.3.0/24   100.64.4.0/24   100.64.4.0/24   10.0.3.0/24   10.0.4.0/24   10.0.5.0/24
az3 100.64.6.0/24   100.64.7.0/24   100.64.7.0/24   10.0.6.0/24   10.0.7.0/24   10.0.8.0/24

marcel-aws-tgw-site-2: 

       ------- Service VPC (100.64.32.0/20) ------  ------ Spoke VPC (10.0.32.0/20) --------

       external        internal        workload       external      internal      workload
az1 100.64.32.0/24  100.64.33.0/24  100.64.34.0/24  10.0.32.0/24  10.0.33.0/24  10.0.34.0/24
az2 100.64.35.0/24  100.64.36.0/24  100.64.37.0/24  10.0.35.0/24  10.0.36.0/24  10.0.37.0/24
az3 100.64.38.0/24  100.64.39.0/24  100.64.40.0/24  10.0.38.0/24  10.0.39.0/24  10.0.40.0/24
```

## Deploy

Deployment is broken down in several individual terraform folders, allowing for more flexibility in changing Terraform configurations. The order of launch is critical, as some depend on tfvars (JSON format) provided by others. The correct order of launch is 

```
terraform -chdir=base-aws-network-1 apply --auto-approve
terraform -chdir=base-aws-network-2 apply --auto-approve
terraform -chdir=base-aws-peering   apply --auto-approve
terraform -chdir=tgw-site-1         apply --auto-approve
terraform -chdir=tgw-site-2         apply --auto-approve
terraform -chdir=tgw-workload-1     apply --auto-approve
terraform -chdir=tgw-workload-2     apply --auto-approve
```

The base-aws-peering depends on input from network-1 and network-2, but I couldn't find an
obvious way to feed data from more than one terraform config, as the name terraform.tfvars can't
be changed (because tf files can be broken down into individual files, I wrongly thought 
this also applies to terraform.tfvars).

The F5 distributed cloud AWS TGW sites aren't deployed via terraform, only their templates are 
created. To deploy the sites, log into F5 distributed cloud console, go to Site Management -> 
AWS TGW Sites and hit 'Apply' button next to created site names.

## Helper scripts

[set-aws-region.sh](set-aws-region.sh) show the AWS region set currently and changes it
when providing the new region name as argument. This script does a mass search/replace in the
relevant TF configuration files.

```
$ ./set-aws-region.sh               
Usage: ./set-aws-region.sh region                                     

current region set to us-west-2         
```

[list-sites.sh](list-sites.sh) shows the public and private IP addresses of the deployed
cloud sites:

```
$ ./list-sites.sh                   
marcel-aws-tgw-site-1:                                                
master-0        35.162.250.202  100.64.0.132                          
master-1        52.11.65.198    100.64.3.134                          
master-2        35.83.219.65    100.64.6.194                          

marcel-aws-tgw-site-2:                                                
master-0        44.230.239.119  100.64.32.220                         
master-1        52.35.236.45    100.64.35.51                          
master-2        54.218.28.252   100.64.38.160                         
```