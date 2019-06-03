package(default_visibility = ["//visibility:public"])

constraint_value(
    name = "avr",
    constraint_setting = "@bazel_tools//platforms:cpu",
)

config_setting(
    name = "avr_config",
    constraint_values = [
        ":avr",
    ]
)

constraint_value(
    name = "bare_metal",
    constraint_setting = "@bazel_tools//platforms:os"
)

platform(
    name = "avr_common",
    constraint_values = [
        "@AvrToolchain//platforms:bare_metal",
        "@AvrToolchain//platforms:avr"
    ]
)

platform(
    name = "Motherboard",
    constraint_values = [
        "@AvrToolchain//platforms/mcu:atmega32u4",
        "@AvrToolchain//platforms/misc:lufa_uart",
        "@AvrToolchain//platforms/misc:lis2de",
        "@AvrToolchain//platforms/misc:has_mrf",
        "@AvrToolchain//platforms/cpu_frequency:8mhz",
    ],
    parents = [":avr_common"]
)

platform(
    name = "ElasticNode_v3",
    constraint_values = [
        "@AvrToolchain//platforms/mcu:atmega64",
        "@AvrToolchain//platforms/misc:hardware_uart",
        "@AvrToolchain//platforms/misc:has_mrf",
        "@AvrToolchain//platforms/cpu_frequency:12mhz",
    ],
    parents = [":avr_common"]
)

platform(
    name = "ElasticNode_v4",
    constraint_values = [
            "@AvrToolchain//platforms/cpu_frequency:8mhz",
            "@AvrToolchain//platforms/misc:lufa_uart",
            "@AvrToolchain//platforms/misc:fpga_connected",
            "@AvrToolchain//platforms/mcu:at90usb1287",
    ],
    parents = [":avr_common"],
)

