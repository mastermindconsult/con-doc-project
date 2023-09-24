# use local-exec provisioner to build and push the Docker image

resource "null_resource" "docker_build_push" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    working_dir = "Docker_Image"
    command     = "chmod +x update-ecr.sh && sh -x update-ecr.sh"

  }
  depends_on = [aws_ecrpublic_repository.ecr_repo, aws_ecrpublic_repository_policy.repo_policy]
}