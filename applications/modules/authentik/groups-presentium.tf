resource "authentik_group" "students" {
  name = "Presentium Students"
}

resource "authentik_group" "teachers" {
  name   = "Presentium Teachers"
  parent = authentik_group.students.id
}

resource "authentik_group" "admins" {
  name         = "Presentium Admins"
  parent       = authentik_group.teachers.id
  is_superuser = true
}
