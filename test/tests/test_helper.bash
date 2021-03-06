TEST_SOURCE_DIR=src
EXCLUDE="--exclude-function=dummy,dummy2"
GLOBAL_ARGS=${EXCLUDE}

CCSM="${CCSM_EXE} ${GLOBAL_ARGS}"

assert_ccsm_output() {
    : "${output?}"

    if [ "${OS}" == "Windows_NT" ]; then
      # Fix line-endings
      expected="$(echo "${1-}" | awk 'sub("$", "\r")')"
    else
      # Fix path separators
      expected="$(echo "${1-}" | sed -e 's/src\\/src\//g;')"
    fi

    if [[ "$output" != *"$expected"* ]]; then
      batslib_print_kv_single_or_multi 9 \
      'substring' "$expected" \
      'output'    "$output" \
      | batslib_decorate 'output does not contain substring' \
      | fail
    fi
}

source ../externals/test/test_helper/bats-support/load.bash
source ../externals/test/test_helper/bats-assert/load.bash
