##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

variable "configs" {
  description = "Configuration object describing all the Amazon Q Chatbot configurations"
  type        = any
  default     = {}
}