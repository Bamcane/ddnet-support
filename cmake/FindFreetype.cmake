if(NOT CMAKE_CROSSCOMPILING)
  find_package(PkgConfig QUIET)
  pkg_check_modules(PC_FREETYPE freetype2)
endif()

set_extra_dirs_lib(FREETYPE freetype)
find_library(FREETYPE_LIBRARY
  NAMES freetype.6 freetype
  HINTS ${HINTS_FREETYPE_LIBDIR} ${PC_FREETYPE_LIBDIR} ${PC_FREETYPE_LIBRARY_DIRS}
  PATHS ${PATHS_FREETYPE_LIBDIR}
  ${CROSSCOMPILING_NO_CMAKE_SYSTEM_PATH}
)
set_extra_dirs_include(FREETYPE freetype "${FREETYPE_LIBRARY}")
find_path(FREETYPE_INCLUDEDIR
  NAMES freetype/config/ftheader.h config/ftheader.h
  PATH_SUFFIXES freetype2
  HINTS ${HINTS_FREETYPE_INCLUDEDIR} ${PC_FREETYPE_INCLUDEDIR} ${PC_FREETYPE_INCLUDE_DIRS}
  PATHS ${PATHS_FREETYPE_INCLUDEDIR}
  ${CROSSCOMPILING_NO_CMAKE_SYSTEM_PATH}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Freetype DEFAULT_MSG FREETYPE_LIBRARY FREETYPE_INCLUDEDIR)

mark_as_advanced(FREETYPE_LIBRARY FREETYPE_INCLUDEDIR)

if(FREETYPE_FOUND)
  set(FREETYPE_LIBRARIES ${FREETYPE_LIBRARY})
  set(FREETYPE_INCLUDE_DIRS ${FREETYPE_INCLUDEDIR})

  is_bundled(FREETYPE_BUNDLED "${FREETYPE_LIBRARY}")
  set(FREETYPE_COPY_FILES)
  if(FREETYPE_BUNDLED)
    if(TARGET_OS STREQUAL "windows" AND TARGET_CPU_ARCHITECTURE STREQUAL "arm64")
      set(FREETYPE_COPY_FILES "${EXTRA_FREETYPE_LIBDIR}/libfreetype-6.dll")
    elseif(TARGET_OS STREQUAL "windows")
      set(FREETYPE_COPY_FILES "${EXTRA_FREETYPE_LIBDIR}/libfreetype.dll")
    elseif(TARGET_OS STREQUAL "mac")
      set(FREETYPE_COPY_FILES "${EXTRA_FREETYPE_LIBDIR}/libfreetype.6.dylib")
    endif()
  endif()
endif()
