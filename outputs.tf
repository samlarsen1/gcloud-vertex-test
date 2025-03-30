output "notebook_url" {
    value = format(
        "https://console.cloud.google.com/vertex-ai/workbench/instances/details/%s?project=%s",
        google_workbench_instance.vertex_notebook.name,
        var.project_id
    )
    description = "URL to access the Vertex AI Workbench notebook"
}