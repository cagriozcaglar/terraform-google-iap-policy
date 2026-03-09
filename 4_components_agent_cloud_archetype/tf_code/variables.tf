variable "app_id" {
  description = "App Engine application ID. Defaults to `project_id` if not set. Required if `web_type` is `appEngine` and the App Engine app ID is not the same as the project ID."
  type        = string
  default     = null
}

variable "bindings" {
  description = "A map of IAM bindings. The key is the role and the value is an object with a `members` list and an optional `condition` block. An empty map creates no bindings."
  type = map(object({
    members = list(string)
    condition = optional(object({
      title       = string
      description = optional(string)
      expression  = string
    }))
  }))
  default = {}
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs. If null, no resources will be created."
  type        = string
  default     = null
}

variable "web_backend_service" {
  description = "The name of the backend service. Required if `web_type` is `backendServices`."
  type        = string
  default     = null
}

variable "web_type" {
  description = "The type of IAP web resource. One of `appEngine` or `backendServices`. If null, no resources will be created."
  type        = string
  default     = null
  validation {
    condition     = var.web_type != null ? contains(["appEngine", "backendServices"], var.web_type) : true
    error_message = "The web_type must be either 'appEngine', 'backendServices', or null."
  }
}
