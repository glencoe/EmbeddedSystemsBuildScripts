def _write_mcu_constraints(repository_ctx, mcu_list):
    _write_constraints(repository_ctx, "mcu", mcu_list, "platforms/mcu/BUILD")

def _write_cpu_frequency_constraints(repository_ctx, cpu_frequency_list):
    _write_constraints(repository_ctx, "cpu_frequency", cpu_frequency_list, "platforms/cpu_frequency/BUILD")

def _write_constraints(repository_ctx, setting, constraint_list, path):
    result = """package(default_visibility = ["//visibility:public"])

constraint_setting(name = "{}")
        """.format(setting)
    for constraint in constraint_list:
        result += """
constraint_value(name = "{constraint}", constraint_setting = ":{setting}")
config_setting(name = "{constraint}_config", constraint_values = ["{constraint}"])
        """.format(constraint = constraint, setting = setting)
    repository_ctx.file(path, result)

def write_constraints(repository_ctx, paths):
    _write_cpu_frequency_constraints(repository_ctx, ["{}mhz".format(x) for x in range(1, 32)])
    _write_mcu_constraints(repository_ctx, repository_ctx.attr.mcu_list)
    _write_constraints(
        repository_ctx,
        "baud_rate",
        repository_ctx.attr.baud_rates,
        "platforms/baud_rate/BUILD",
    )
    repository_ctx.template(
        "platforms/cpu_frequency/cpu_frequency.bzl",
        paths["@EmbeddedSystemsBuildScripts//AvrToolchain:platforms/cpu_frequency/cpu_frequency.bzl.tpl"],
    )
    _write_constraints(
        repository_ctx,
        "uploader",
        ["dfu_programmer", "avrdude"],
        "platforms/uploader/BUILD",
    )
    repository_ctx.template("platforms/misc/BUILD", paths["@EmbeddedSystemsBuildScripts//AvrToolchain:platforms/misc/BUILD.tpl"])
    repository_ctx.template("platforms/BUILD", paths["@EmbeddedSystemsBuildScripts//AvrToolchain:platforms/BUILD.tpl"])
