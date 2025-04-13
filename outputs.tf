output "notebook_url" {
    value = format(
        "https://console.cloud.google.com/vertex-ai/workbench/instances/details/%s?project=%s",
        local.install_vertex_workbench ? google_workbench_instance.vertex_notebook[0].name : "NO_WORKBENCH_INSTALLED",
        var.project_id
    )
    description = "URL to access the Vertex AI Workbench notebook"
}
