
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
