ACCOUNT_ID=$(AWS_ACCOUNT_ID)

hello:
	@echo "Hello, World $(ACCOUNT_ID)"

init:
	@terraform -chdir="./infrastructure" init

build:
	@printf "Building the application!\n"
	@./mvnw clean package
	@if [ $$? -ne 0 ]; then \
	printf "Java application build failed! No new Lambda Function will be deployed!!!i\n"; \
	exit -1;\
	fi;

deploy:
	@echo "Deploying the Terraform!"
	@terraform -chdir="./infrastructure" apply -auto-approve

destroy:
	@echo "Destroying the resource!"
	@terraform -chdir="./infrastructure" destroy -auto-approve

clean:
	@./mvnw clean
	@rm -rf ./infrastructure/.terraform
	@rm -rf ./infrastructure/.terraform.lock.hcl
	@rm -rf ./infrastructure/*.tfplan
	@rm -rf ./infrastructure/terraform.tfstate
	@rm -rf ./infrastructure/terraform.tfstate.backup