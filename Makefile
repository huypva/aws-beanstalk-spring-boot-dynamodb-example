hello:
	@echo "Hello, World"

init:
	@terraform -chdir="./infrastructure" init

build:
	@printf "Building the application!\n"
	@./mvnw clean package -Dspring.profiles.active=aws -Dmaven.test.skip
	@if [ $$? -ne 0 ]; then \
	printf "Java application build failed! No new Lambda Function will be deployed!!!i\n"; \
	exit -1;\
	fi;

run-local:
	@printf "Run local"
	@./mvnw spring-boot:run

deploy:
	@echo "Deploying the Terraform!"
	@terraform -chdir="./infrastructure" apply -auto-approve -var="aws_access_key_id=$(AWS_ACCESS_KEY_ID)" -var="aws_secret_access_key=$(AWS_SECRET_ACCESS_KEY)"

destroy:
	@echo "Destroying the resource!"
	@terraform -chdir="./infrastructure" destroy -auto-approve -var="aws_access_key_id=$(AWS_ACCESS_KEY_ID)" -var="aws_secret_access_key=$(AWS_SECRET_ACCESS_KEY)"

clean:
	@./mvnw clean
	@rm -rf ./infrastructure/.terraform
	@rm -rf ./infrastructure/.terraform.lock.hcl
	@rm -rf ./infrastructure/*.tfplan
	@rm -rf ./infrastructure/terraform.tfstate
	@rm -rf ./infrastructure/terraform.tfstate.backup