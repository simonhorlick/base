load(
    "@io_bazel_rules_go//go:def.bzl",
    "go_library",
)

def go_grpc_gateway_library(name, src):
  basename = src[:-len(".proto")]
  protoc_label = str(Label("@protobuf//:protoc"))
  go_plugin_label = str(Label("@com_github_golang_protobuf//protoc-gen-go"))
  grpc_gateway_plugin_label = str(Label("@com_github_grpc_ecosystem_grpc_gateway//protoc-gen-grpc-gateway"))

  # This is really nasty. We use the generated sources under
  # @com_github_grpc_ecosystem_grpc_gateway//third_party/googleapis/google/api:go_default_library
  # for the go compilation step, but the actual proto files come from
  # //third_party/googleapis/google/api in this repository.
  inputmaps = "Mgoogle/api/annotations.proto=github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis/google/api"

  annotations_label = str(Label("//third_party/googleapis"))

  # Generate stub and gateway
  native.genrule(
      name = name + "_codegen",
      srcs = [src, annotations_label],
      tools = [protoc_label, go_plugin_label, grpc_gateway_plugin_label],
      cmd = "\\\n".join([
          "$(location " + protoc_label + ")",
          "    -I.",
          "    -Iexternal/com_github_simonhorlick_base/third_party/googleapis", # This is super hacky
          "    --plugin=protoc-gen-go=$(location " + go_plugin_label + ")",
          "    --plugin=grpc-gateway=$(location " + grpc_gateway_plugin_label + ")",
          "    --go_out=" + inputmaps + ",plugins=grpc:$(GENDIR)",
          "    --grpc-gateway_out=logtostderr=true:$(GENDIR)",
          "    $(location " + src + ")"]),
      outs = [basename + ".pb.go", basename + ".pb.gw.go"])

  go_library(
      name = name,
      srcs = [basename + ".pb.go", basename + ".pb.gw.go"],
      deps = [
          # proto dependencies
          "@com_github_golang_protobuf//proto:go_default_library",
          # grpc gateway dependencies
          "@com_github_grpc_ecosystem_grpc_gateway//runtime:go_default_library",
          "@com_github_grpc_ecosystem_grpc_gateway//utilities:go_default_library",
          "@com_github_grpc_ecosystem_grpc_gateway//third_party/googleapis/google/api:go_default_library",
          # grpc dependencies
          "@org_golang_x_net//context:go_default_library",
          "@org_golang_google_grpc//:go_default_library",
          "@org_golang_google_grpc//codes:go_default_library",
          "@org_golang_google_grpc//grpclog:go_default_library",
          ],
      )
