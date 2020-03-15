#The Terraforms
plan: clean
	terraform init -backend-config="bucket=eskin-dev-tf-remote-state" && \
	terraform plan -out main.tfplan -var-file=gw.tfvars

apply:
	terraform init -backend-config="bucket=eskin-dev-tf-remote-state" && \
	terraform apply main.tfplan 

#The SAMs
build:
	sam build -u 

deploy: package
	sam deploy --stack-name $(app) --s3-bucket eskin-app-lambdas-$(env) --region us-east-1


clean:
	rm -rf .terraform/
	rm -rf *.tfplan
	rm -rf .aws-sam
	rm -rf *.toml

check-env:
ifndef env
	$(error Environment is undefined)
endif

check-app:
ifndef app
	$(error Application Name is undefined)
endif