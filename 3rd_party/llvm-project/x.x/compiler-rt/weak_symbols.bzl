"""Darwin weak/undefined symbol link flags for compiler-rt runtimes.

On Darwin the sanitizer runtimes are linked with `-Wl,-U,<symbol>` for each
symbol listed in `compiler-rt/lib/<name>/weak_symbols.txt`, so that programs may
override them at runtime (for example `__asan_default_options`). This mirrors
`add_weak_symbols()` in `compiler-rt/cmake/Modules/SanitizerUtils.cmake`, which
emits `-Wl,-U,${symbol}` per symbol. The symbol names are kept verbatim from the
`weak_symbols.txt` files (Mach-O leading-underscore form).
"""

# compiler-rt/lib/sanitizer_common/weak_symbols.txt
SANITIZER_COMMON_WEAK_SYMBOLS = [
    "___sanitizer_free_hook",
    "___sanitizer_get_dtls_size",
    "___sanitizer_malloc_hook",
    "___sanitizer_report_error_summary",
    "___sanitizer_sandbox_on_notify",
    "___sanitizer_symbolize_code",
    "___sanitizer_symbolize_data",
    "___sanitizer_symbolize_frame",
    "___sanitizer_symbolize_demangle",
    "___sanitizer_symbolize_flush",
    "___sanitizer_symbolize_set_demangle",
    "___sanitizer_symbolize_set_inline_frames",
    "__dyld_get_dyld_header",
]

# compiler-rt/lib/asan/weak_symbols.txt
ASAN_WEAK_SYMBOLS = [
    "___asan_default_options",
    "___asan_default_suppressions",
    "___asan_on_error",
    "___asan_set_shadow_00",
    "___asan_set_shadow_01",
    "___asan_set_shadow_02",
    "___asan_set_shadow_03",
    "___asan_set_shadow_04",
    "___asan_set_shadow_05",
    "___asan_set_shadow_06",
    "___asan_set_shadow_07",
    "___asan_set_shadow_f1",
    "___asan_set_shadow_f2",
    "___asan_set_shadow_f3",
    "___asan_set_shadow_f4",
    "___asan_set_shadow_f5",
    "___asan_set_shadow_f6",
    "___asan_set_shadow_f7",
    "___asan_set_shadow_f8",
]

# compiler-rt/lib/lsan/weak_symbols.txt
LSAN_WEAK_SYMBOLS = [
    "___lsan_default_options",
    "___lsan_default_suppressions",
    "___lsan_is_turned_off",
]

# compiler-rt/lib/ubsan/weak_symbols.txt
UBSAN_WEAK_SYMBOLS = [
    "___ubsan_default_options",
]

# compiler-rt/lib/xray/weak_symbols.txt
XRAY_WEAK_SYMBOLS = [
    "___start_xray_fn_idx",
    "___start_xray_instr_map",
    "___stop_xray_fn_idx",
    "___stop_xray_instr_map",
    "___xray_default_options",
]

def weak_symbol_link_flags(symbol_lists):
    """Returns `-Wl,-U,<symbol>` link flags for the given lists of weak symbols.

    Args:
      symbol_lists: a list of symbol-name lists (e.g. [ASAN_WEAK_SYMBOLS, ...]).
    """
    return [
        "-Wl,-U,{}".format(symbol)
        for symbols in symbol_lists
        for symbol in symbols
    ]
