package("rpm")
    set_kind("binary")
    set_homepage("https://rpm.org")
    set_description("Standard unix software packaging tool")

    add_urls("https://github.com/rpm-software-management/rpm/archive/refs/tags/rpm-$(version)-release.tar.gz")

    add_versions("4.19.0", "19083de356ef80f2497686fd6e52011ec2d3e2dfb481e113a9f4dd1b03b47347")

    add_deps("cmake", "lua")
    add_deps("python 3.x", {kind = "binary"})
    add_deps("popt", "libcap", "acl", "sqlite3")

    on_install("linux", function (package)
        local configs = {
            "-DCMAKE_INSTALL_LOCALSTATEDIR=etc",
            "-DCMAKE_INSTALL_SHAREDSTATEDIR=var/lib",
            "-DCMAKE_INSTALL_LOCALSTATEDIR=var",
            "-DENABLE_NLS=ON",
            "-DENABLE_PLUGINS=OFF",
            "-DWITH_AUDIT=OFF",
            "-DWITH_INTERNAL_OPENPGP=ON",
            "-DWITH_OPENSSL=ON",
            "-DWITH_SELINUX=OFF",
            "-DENABLE_TESTSUITE=OFF"}
        import("package.tools.cmake").install(package, configs)
    end)

    on_test(function (package)
        os.run("rpm --version")
        os.run("rpmbuild --version")
    end)
