# IAP Web IAM Binding Module

This module manages Identity-Aware Proxy (IAP) IAM bindings for Google Cloud web resources, including App Engine applications and Backend Services.

It simplifies the process of applying IAM policies to IAP-secured resources by conditionally creating the correct type of IAM binding based on the specified web resource type.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Usage

This module is designed to be flexible. Below are two common usage examples, one for an App Engine application and one for a Backend Service.

### App Engine IAP Binding

This example grants the `IAP-secured Web App User` role to a user and a group for an App Engine application.

```hcl
module "iap_iam_app_engine" {
  source   = "./path/to/module" # Replace with the actual source
  project_id = "your-gcp-project-id"
  web_type = "appEngine"
  # app_id is optional and defaults to project_id, but can be set explicitly
  # app_id   = "your-app-engine-app-id" 

  bindings = {
    "roles/iap.httpsResourceAccessor" = {
      members = [
        "user:test-user@example.com",
        "group:test-group@example.com",
      ]
    }
  }
}
```

### Backend Service IAP Binding with Condition

This example grants the `IAP-secured Web App User` role to a service account for a specific backend service, with an IAM condition attached.

```hcl
module "iap_iam_backend_service" {
  source              = "./path/to/module" # Replace with the actual source
  project_id          = "your-gcp-project-id"
  web_type            = "backendServices"
  web_backend_service = "my-load-balancer-backend-service"

  bindings = {
    "roles/iap.httpsResourceAccessor" = {
      members = [
        "serviceAccount:my-sa@your-gcp-project-id.iam.gserviceaccount.com",
      ],
      condition = {
        title      = "access_until_2025"
        description = "Allow access only until the end of 2024."
        expression = "request.time < timestamp('2025-01-01T00:00:00Z')"
      }
    }
  }
}
```

## Requirements

The following requirements are needed by this module.

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.53.0 |

## Providers

The following providers are used by this module.

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.53.0 |

## Resources

The following resources are used by this module.

- [google_iap_web_backend_service_iam_binding.backend_service_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iap_web_backend_service_iam_binding) (resource)
- [google_iap_web_type_app_engine_iam_binding.app_engine_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iap_web_type_app_engine_iam_binding) (resource)

## Inputs

The following input variables are supported:

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_id"></a> [app\_id](#input\_app\_id) | App Engine application ID. Defaults to `project_id` if not set. Required if `web_type` is `appEngine` and the App Engine app ID is not the same as the project ID. | `string` | `null` | no |
| <a name="input_bindings"></a> [bindings](#input\_bindings) | A map of IAM bindings. The key is the role and the value is an object with a `members` list and an optional `condition` block. An empty map creates no bindings. | <pre>map(object({<br>    members = list(string)<br>    condition = optional(object({<br>      title       = string<br>      description = optional(string)<br>      expression  = string<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the resource belongs. If null, no resources will be created. | `string` | `null` | no |
| <a name="input_web_backend_service"></a> [web\_backend\_service](#input\_web\_backend\_service) | The name of the backend service. Required if `web_type` is `backendServices`. | `string` | `null` | no |
| <a name="input_web_type"></a> [web\_type](#input\_web\_type) | The type of IAP web resource. One of `appEngine` or `backendServices`. If null, no resources will be created. | `string` | `null` | no |

## Outputs

The following outputs are exported:

| Name | Description |
|------|-------------|
| <a name="output_app_engine_bindings"></a> [app\_engine\_bindings](#output\_app\_engine\_bindings) | The created IAP IAM bindings for the App Engine application. |
| <a name="output_backend_service_bindings"></a> [backend\_service\_bindings](#output\_backend\_service\_bindings) | The created IAP IAM bindings for the Backend Service. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
