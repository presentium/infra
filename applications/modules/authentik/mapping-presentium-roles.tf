resource "authentik_scope_mapping" "scope-roles" {
  name       = "Presentium Roles"
  scope_name = "roles"
  expression = <<-EOT
    roles = []
    if ak_is_group_member(request.user, name="${authentik_group.students.name}"):
      roles.append("student")
    if ak_is_group_member(request.user, name="${authentik_group.teachers.name}"):
      roles.append("teacher")
    if ak_is_group_member(request.user, name="${authentik_group.admins.name}"):
      roles.append("admin")

    return {
      "roles": roles
    }
  EOT
}
