plan: clean
	terraform init -backend-config="bucket=eskin-dev-tf-remote-state" && \
	terraform plan -out main.tfplan -var-file=gw.tfvars

apply:
	terraform init -backend-config="bucket=eskin-dev-tf-remote-state" && \
	terraform apply main.tfplan 

clean:
	rm -rf .terraform/
	rm -rf *.tfplan
	rm -rf .aws-sam