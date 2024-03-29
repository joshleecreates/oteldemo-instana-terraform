resource "instana_custom_dashboard" "collector-dashboard" {
  title = "Collector Dashboard"

  access_rule { 
    access_type = "READ_WRITE"
    relation_type = "GLOBAL"
  }

  widgets = file("${path.module}/dashboard.json")
}
