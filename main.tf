resource "spacelift_stack_dependency" "this" {
  stack_id            = spacelift_stack.first_stack.id
  depends_on_stack_id = spacelift_stack.second_stack.id
}

resource "spacelift_stack_dependency_reference" "this" {
  stack_dependency_id = spacelift_stack_dependency.this.id
  output_name         = "second_stack_output"
  input_name          = "TF_VAR_second_stack_output"
}

resource "spacelift_stack_dependency" "that" {
  stack_id            = spacelift_stack.first_stack.id
  depends_on_stack_id = spacelift_stack.third_stack.id
}

resource "spacelift_stack_dependency_reference" "that" {
  stack_dependency_id = spacelift_stack_dependency.that.id
  output_name         = "third_stack_output"
  input_name          = "TF_VAR_third_stack_output"
}

resource "spacelift_stack" "first_stack" {
  branch     = "main"
  name       = "first stack"
  autodeploy = true
  repository = "spacelift_outputs_test"
  project_root      = "first_stack"
}

resource "spacelift_stack" "second_stack" {
  branch     = "main"
  name       = "second stack"
  repository = "spacelift_outputs_test"
  project_root      = "second_stack"
  autodeploy = true
}

resource "spacelift_run" "second" {
  stack_id = spacelift_stack.second_stack.id

  keepers = {
    branch = spacelift_stack.second_stack.branch
  }
}
resource "spacelift_stack" "third_stack" {
  branch     = "main"
  name       = "third stack"
  repository = "spacelift_outputs_test"
  project_root      = "third_stack"
  autodeploy = true
}

resource "spacelift_run" "third" {
  stack_id = spacelift_stack.third_stack.id

  keepers = {
    branch = spacelift_stack.third_stack.branch
  }
}

terraform {
  required_providers {
    spacelift = {
      source  = "spacelift.io/spacelift-io/spacelift"
      version = "1.13.0"
    }
  }
}

provider "spacelift" {}
