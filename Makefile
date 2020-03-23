#The Terraforms
plan: clean
	terraform init -backend-config="bucket=eskin-dev-tf-remote-state" && \
	terraform plan -out main.tfplan -var-file=gw.tfvars

apply:
	terraform init -backend-config="bucket=eskin-dev-tf-remote-state" && \
	terraform apply main.tfplan 

#The SAMs
gen-build:
	sam build -u 

go-build:
	cd golang/myip; \
	GOOS=linux GOARCH=amd64 go build -o main main.go

deploy: $(type)-build check-type
	sam deploy --stack-name $(app) --s3-bucket eskin-app-lambdas-$(env) --region us-east-1 \
	--parameter-overrides LambdaExecRole=/dev/ExecutionRoleARN \
		UserPool=/dev/userpoolArn \
	--capabilities CAPABILITY_IAM


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

check-type:
ifndef type
	$(error app type undefined, expected gen or go)
endif