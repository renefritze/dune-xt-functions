# ~~~
# This file is part of the dune-xt-functions project:
#   https://github.com/dune-community/dune-xt-functions
# Copyright 2009-2018 dune-xt-functions developers and contributors. All rights reserved.
# License: Dual licensed as BSD 2-Clause License (http://opensource.org/licenses/BSD-2-Clause)
#      or  GPL-2.0+ (http://opensource.org/licenses/gpl-license)
#          with "runtime exception" (http://www.dune-project.org/license.html)
# Authors:
#   Felix Schindler (2016 - 2017)
#   René Fritze     (2016, 2018)
#   TiKeil          (2018)
#   Tobias Leibner  (2016, 2018)
# ~~~

set(lib_dune_xt_functions_sources expression/mathexpr.cc)
dune_library_add_sources(dunextfunctions SOURCES ${lib_dune_xt_functions_sources})
add_subdirectory(test EXCLUDE_FROM_ALL)
