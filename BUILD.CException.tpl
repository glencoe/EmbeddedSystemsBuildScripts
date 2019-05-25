load("@{name}//:helpers.bzl", "mcu_avr_gcc_flag")

filegroup(
    name = "CExceptionSrc",
    srcs = ["lib/CException.c"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "CExceptionHdr",
    srcs = ["lib/CException.h"],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "CException",
    srcs = [":CExceptionSrc"],
    hdrs = [":CExceptionHdr"],
    copts = ["-include", "stdint.h"] + mcu_avr_gcc_flag(),
    # symbol definitions in defines will be propagated to every target dependent on CException
    defines = [
        "CEXCEPTION_T=uint8_t",
        "CEXCEPTION_NONE=0x00",
    ],
    linkstatic = True,
    strip_include_prefix = "lib/",
    visibility = ["//visibility:public"],
)
