


resource "google_workbench_instance" "vertex_notebook" {
  name     = var.notebook_name // Use variables for naming
  location = "${var.region}-b" // Concatenate a zone suffix to the region variable
}


