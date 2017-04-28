# - Config file for the OKVIS package
# It defines the following variables
#  OKVIS_INCLUDE_DIRS - include directories for FooBar
#  OKVIS_LIBRARIES    - libraries to link against
#  OKVIS_EXECUTABLE   - the okvis_app_synchronous executable
#  OKVIS_CERES_CONFIG - path to CeresConfig.cmake, to use find_package(ceres)

find_package(PkgConfig)

set(VisensorPcDirectory "/home/nubot/kinetic_ws/src/okvis_ros/okvis/ThirdPackage/VISensor/share/pkgconfig")
SET(ENV{PKG_CONFIG_PATH} "${VisensorPcDirectory}")

pkg_check_modules(PC_VISENSOR visensor)

#message("pkg: ${PC_VISENSOR_INCLUDEDIRS}")
set(VISENSOR_DEFINITIONS ${PC_VISENSOR_CFLAGS_OTHER})

find_path(VISensorDriver_INCLUDE_DIR visensor.hpp
          HINTS ${PC_VISENSOR_INCLUDEDIR} ${PC_VISENSOR_INCLUDE_DIRS}
          PATH_SUFFIXES visensor )

find_library(VISensorDriver_LIBRARY NAMES libvisensor.so
             HINTS ${PC_VISENSOR_LIBDIR} ${PC_VISENSOR_LIBRARY_DIRS} /usr/local/lib)

set(VISENSOR_LIBRARY      ${VISensorDriver_LIBRARY})
set(VISENSOR_INCLUDE_DIR  ${PC_VISENSOR_INCLUDE_DIRS})
set(VISENSOR_LIBRARIES    ${VISENSOR_LIBRARY} )
set(VISENSOR_INCLUDE_DIRS ${VISENSOR_INCLUDE_DIR} )


include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set LIBXML2_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(VISensorDriver  DEFAULT_MSG
                                  VISensorDriver_LIBRARY VISensorDriver_INCLUDE_DIR)

mark_as_advanced(VISensorDriver_INCLUDE_DIR VISensorDriver_LIBRARY )
