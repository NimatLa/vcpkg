vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO voikko/corevoikko
    REF rel-libvoikko-${VERSION}
    SHA512 cb5217b5fddead3d3c3af080ef8e98927ab729605f69c1bafc7e33755e0aa1113ce91a36a26e0389a66f1751964f2a4518b134c6805868ed70b02ea2f6224827
    PATCHES
        "cl-flags.patch"
)

vcpkg_find_acquire_program(PYTHON3)
foreach(PYTHON_PATH ${PYTHON3})
    get_filename_component(PYTHON_DIR ${PYTHON_PATH} DIRECTORY)
    vcpkg_add_to_path(${PYTHON_DIR})
endforeach()

vcpkg_make_configure(
    SOURCE_PATH "${SOURCE_PATH}/libvoikko"
    AUTORECONF
    OPTIONS
        "--disable-buildtools"
        "--disable-testtools"
        "--disable-hfst"
)
vcpkg_make_install()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/tools")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")