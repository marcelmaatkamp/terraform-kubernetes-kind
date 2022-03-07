variable "name" {
  type     = string
  nullable = false
}
variable "projectName" {
  type     = string
  nullable = false
}
variable "repoUrl" {
  type     = string
  nullable = false 
}
variable "repoPath" {  
  type     = string
  nullable = false
}
variable "repoTargetRevision" { 
  type     = string
  nullable = false
}
variable "destinationNamespace" {
  type     = string
  nullable = false
}
