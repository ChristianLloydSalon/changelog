#!/bin/bash

CHANGELOG_DIR="./changelog"
UNRELEASED_DIR="$CHANGELOG_DIR/unreleased"

init_changelog() {
    mkdir -p "$UNRELEASED_DIR"
    echo "Initialized changelog with an empty unreleased folder."
}

add_changelog_entry() {
    local change_type="$1"
    local message="$2"

    if [[ ! "added fixed changed" =~ "$change_type" ]]; then
        echo "Invalid change type: $change_type. Valid types are: added, fixed, changed."
        exit 1
    fi

    local timestamp=$(date +"%m%d%Y%H%M%S%3N")
    local changelog_file="$UNRELEASED_DIR/$change_type/CHANGELOG_${change_type^^}_$timestamp"

    mkdir -p "$UNRELEASED_DIR/$change_type"
    echo "$message" > "$changelog_file"
    echo "Added changelog entry: $changelog_file"
}

preview_changelogs() {
    if [ -d "$UNRELEASED_DIR" ]; then
        echo "Previewing all unreleased changelogs:"
        find "$UNRELEASED_DIR" -type f | while read -r file; do
            echo "File: $file"
            cat "$file"
            echo ""
        done
    else
        echo "No unreleased changelogs found."
    fi
}

release_changelogs() {
    local version_name="$1"
    local release_dir="$CHANGELOG_DIR/$version_name"

    if [ -d "$UNRELEASED_DIR" ]; then
        mkdir -p "$release_dir"
        mv "$UNRELEASED_DIR"/* "$release_dir/"
        echo "Released all changelogs to version: $version_name"
        rm -rf "$UNRELEASED_DIR"
    else
        echo "No unreleased changelogs to release."
    fi
    mkdir -p "$UNRELEASED_DIR"
}

case "$1" in
    changelog)
        shift
        case "$1" in
            init)
                init_changelog
                ;;
            added | fixed | changed)
                if [ -z "$2" ]; then
                    echo "Please provide a message for the changelog entry."
                    exit 1
                fi
                add_changelog_entry "$1" "$2"
                ;;
            preview)
                preview_changelogs
                ;;
            release)
                if [ -z "$2" ]; then
                    echo "Please provide a version name for the release."
                    exit 1
                fi
                release_changelogs "$2"
                ;;
            *)
                echo "Usage: $0 changelog {init|added|fixed|changed|preview|release <version_name>} [message]"
                exit 1
                ;;
        esac
        ;;
    *)
        echo "Usage: $0 changelog {init|added|fixed|changed|preview|release <version_name>} [message]"
        exit 1
        ;;
esac
