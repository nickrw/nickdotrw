plan: .terraform/last-plan

.terraform/last-plan: .terraform
	terraform plan -out .terraform/last-plan

clean:
	rm -rf .terraform/last-plan

apply-plan: .terraform/last-plan
	terraform apply .terraform/last-plan

apply-blind:
	terraform apply

.terraform:
	@mkdir .terraform
	$(MAKE) .terraform/terraform.tfstate

.terraform/terraform.tfstate:
	terraform remote config -backend=s3 \
	  -backend-config="bucket=nickrw-terraform" \
	  -backend-config="key=nickdotrw.tfstate" \
	  -backend-config="region=eu-west-2" \
	  -backend-config="profile=personal" \
	  -backend-config="encrypt=true"
