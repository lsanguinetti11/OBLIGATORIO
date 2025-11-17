# resource "aws_ecr_repository" "app_repo" {
#   name                 = "${var.project}-frontend"
#   image_tag_mutability = "MUTABLE"

#   image_scanning_configuration {
#     scan_on_push = true
#   }

#   tags = { Name = "${var.project}-ecr" }
# }

# output "repository_url" {
#   value = aws_ecr_repository.app_repo.repository_url
# }