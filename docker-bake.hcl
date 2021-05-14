variable "NODE_VERSION" {
  default = "12"
}

target "node-version" {
  args = {
    NODE_VERSION = NODE_VERSION
  }
}

group "default" {
  targets = ["build"]
}

group "pre-checkin" {
  targets = ["vendor-update", "format", "build"]
}

group "validate" {
  targets = ["vendor-validate", "format-validate", "build-validate"]
}

target "vendor-update" {
  inherits = ["node-version"]
  dockerfile = "./hack/build.Dockerfile"
  target = "vendor-update"
  output = ["."]
}

target "vendor-validate" {
  inherits = ["node-version"]
  dockerfile = "./hack/build.Dockerfile"
  target = "vendor-validate"
}

target "build" {
  inherits = ["node-version"]
  dockerfile = "./hack/build.Dockerfile"
  target = "build-update"
  output = ["."]
}

target "build-validate" {
  inherits = ["node-version"]
  dockerfile = "./hack/build.Dockerfile"
  target = "build-validate"
}

target "format" {
  inherits = ["node-version"]
  dockerfile = "./hack/build.Dockerfile"
  target = "format-update"
  output = ["."]
}

target "format-validate" {
  inherits = ["node-version"]
  dockerfile = "./hack/build.Dockerfile"
  target = "format-validate"
}

#
#
#

variable "DEFAULT_TAG" {
  default = "ghaction-chocolatey:local"
}

// Special target: https://github.com/docker/metadata-action#bake-definition
target "docker-metadata-action" {
  tags = ["${DEFAULT_TAG}"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  context = "./image"
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
}
