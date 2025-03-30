output "notebook_url" {
  value       = "https://console.cloud.google.com/vertex-ai/workbench/instances/details/${google_notebooks_instance.vertex_notebook.name}?project=${var.project_id}"
  description = "URL to access the Vertex AI Workbench notebook"
}