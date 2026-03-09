output "app_engine_bindings" {
  description = "The created IAP IAM bindings for the App Engine application."
  value       = google_iap_web_type_app_engine_iam_binding.app_engine_binding
}

output "backend_service_bindings" {
  description = "The created IAP IAM bindings for the Backend Service."
  value       = google_iap_web_backend_service_iam_binding.backend_service_binding
}
