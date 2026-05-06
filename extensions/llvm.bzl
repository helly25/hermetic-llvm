load("@llvm-raw//utils/bazel:configure.bzl", _llvm_configure = "llvm_configure")

_LLVM_PROJECT_FILES = {
    "compiler-rt/BUILD.bazel": Label("//3rd_party/llvm-project/x.x/compiler-rt:compiler-rt.BUILD.bazel"),
    "libc/BUILD.bazel": Label("//3rd_party/llvm-project/x.x/libc:libc.BUILD.bazel"),
    "libcxx/BUILD.bazel": Label("//3rd_party/llvm-project/x.x/libcxx:libcxx.BUILD.bazel"),
    "libcxxabi/BUILD.bazel": Label("//3rd_party/llvm-project/x.x/libcxxabi:libcxxabi.BUILD.bazel"),
    "libunwind/BUILD.bazel": Label("//3rd_party/llvm-project/x.x/libunwind:libunwind.BUILD.bazel"),
    "openmp/BUILD.bazel": Label("//3rd_party/llvm-project/x.x/openmp:openmp.BUILD.bazel"),
}

def _llvm_impl(mctx):
    _targets = {}
    for mod in mctx.modules:
        for conf in mod.tags.configure:
            for target in conf.targets:
                _targets[target] = True
    _llvm_configure(
        name = "llvm-project",
        files = _LLVM_PROJECT_FILES,
        targets = _targets.keys(),
    )
    return mctx.extension_metadata(
        reproducible = True,
        root_module_direct_deps = "all",
        root_module_direct_dev_deps = [],
    )

llvm = module_extension(
    implementation = _llvm_impl,
    tag_classes = {
        "configure": tag_class(
            attrs = {
                "targets": attr.string_list(mandatory = True),
            },
        ),
    },
)
