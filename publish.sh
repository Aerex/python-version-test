#!/bin/bash
set -ev

if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; then
    echo "Not a PR"

    # on development branch, we want to auto increment package patch version number
    # and push commit back to repo
    if [ "${TRAVIS_BRANCH}" = "development" ]; then
        echo "On branch: development"
        echo "commit message: ${TRAVIS_COMMIT_MESSAGE}"

        echo "commit: ${TRAVIS_COMMIT}"
        USER_EMAIL=$(git --no-pager show -s --format='%ae' "${TRAVIS_COMMIT}")
        USER_NAME=$(git --no-pager show -s --format='%an' "${TRAVIS_COMMIT}")
        echo "user email: ${USER_EMAIL}"
        echo "user name: ${USER_NAME}"
        git config user.email "${USER_EMAIL}"
        git config user.name "${USER_NAME}"

        git checkout -- .
        currentVersion=$(python -c "print(open('setup.py').read().split('\n')[3].split('='))[1].replace(',','')")
        echo $currentVersion
        if echo "$TRAVIS_COMMIT_MESSAGE" | grep -q "fix" ; then
            bumpversion --list --allow-dirty --current-version $currentVersion patch setup.py
        elif echo "$TRAVIS_COMMIT_MESSAGE" | grep -q "feat" ; then
            bumpversion --list --allow-dirty --current-version $currentVersion minor setup.py
        elif echo "$TRAVIS_COMMIT_MESSAGE" | grep -q "BREAKING CHANGE";  then
            bumpversion --list --allow-dirty --current-version $currentVersion major setup.py
        else
            echo "Could not determine version upgrade defaulting to patch"
            bumpversion --list --allow-dirty --current-version $currentVersion patch setup.py
        fi

        git branch --set-upstream-to origin/development
        git push origin HEAD:development
        git push origin HEAD:development --tags
    fi
else
    echo "Is a PR - do not increment version or publish"
fi