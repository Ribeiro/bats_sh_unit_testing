#!/usr/bin/env bats
setup() {
    load '../test_helper/bats-support/load'
    load '../test_helper/bats-assert/load'
    # ... the remaining setup is unchanged

    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    
    # make executables in src/ visible to PATH
    PATH="$DIR/../../src/users:$PATH"

    # Load shell script before testing
    source users.sh

    # Removing user.conf file used for testing
    rm -rf user.conf
}

teardown() {
    # Used to shutdown Bats testing engine
    rm -f /tmp/bats-tutorial-project-ran
}

@test "Should successfully add a User" {
    run add
    assert_output 'User successfully added!'
}

@test "Should successfully delete a User" {
    run remove
    assert_output 'User successfully removed!'
}

@test "Should successfully create a User config file using ENV_USERNAME" {
    ENV_USERNAME="'Geovanny Ribeiro'"
    run createConfigFileUsingEnv
    assert [ -e 'user.conf' ]
    configFileContent=$(<user.conf)
    assert_equal "$configFileContent" "username='Geovanny Ribeiro'"
}

@test "Should successfully create a User config file using argument" {
    run createConfigFile Geovanny Silva Ribeiro
    assert [ -e 'user.conf' ]
    configFileContent=$(<user.conf)
    assert_equal "$configFileContent" "username='Geovanny Silva Ribeiro'"
}