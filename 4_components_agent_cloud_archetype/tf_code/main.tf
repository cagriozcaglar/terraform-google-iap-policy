# This module manages IAP IAM policies for web-type resources,
# such as App Engine applications and backend services.
# It uses specific IAP IAM resources for App Engine and Backend Services
# and the `for_each` meta-argument to conditionally create the correct
# bindings based on the `web_type` variable.

# Creates IAM bindings for an IAP-secured App Engine application.
resource "google_iap_web_type_app_engine_iam_binding" "app_engine_binding" {
  # Create a binding for each role if the web_type is 'appEngine'.
  # No resources are created if web_type is null or bindings is an empty map.
  for_each = var.web_type == "appEngine" ? var.bindings : {}

  # The ID of the project where the App Engine application is located.
  project = var.project_id

  # The App Engine application ID. Defaults to the project ID if not specified.
  app_id = coalesce(var.app_id, var.project_id)

  # The role that should be applied.
  role = each.key

  # A list of members who should be granted the role.
  members = each.value.members

  # Optional IAM condition block to attach to the binding.
  dynamic "condition" {
    for_each = each.value.condition != null ? [each.value.condition] : []
    content {
      # The title for the condition.
      title = condition.value.title
      # An optional description for the condition.
      description = condition.value.description
      # The CEL expression for the condition.
      expression = condition.value.expression
    }
  }
}

# Creates IAM bindings for an IAP-secured backend service.
resource "google_iap_web_backend_service_iam_binding" "backend_service_binding" {
  # Create a binding for each role if the web_type is 'backendServices'.
  # No resources are created if web_type is null or bindings is an empty map.
  for_each = var.web_type == "backendServices" ? var.bindings : {}

  # The ID of the project where the backend service is located.
  project = var.project_id

  # The name of the backend service.
  web_backend_service = var.web_backend_service

  # The role that should be applied.
  role = each.key

  # A list of members who should be granted the role.
  members = each.value.members

  # Optional IAM condition block to attach to the binding.
  dynamic "condition" {
    for_each = each.value.condition != null ? [each.value.condition] : []
    content {
      # The title for the condition.
      title = condition.value.title
      # An optional description for the condition.
      description = condition.value.description
      # The CEL expression for the condition.
      expression = condition.value.expression
    }
  }
}
