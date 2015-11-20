# antigen-bundle-noload: using antigen directory to manage.
antigen-bundle-noload () {

    # Bundle spec arguments' default values.
    local url="$ANTIGEN_DEFAULT_REPO_URL"
    local loc=/
    local branch=
    local no_local_clone=false
    local btype=plugin

    # Parse the given arguments. (Will overwrite the above values).
    eval "$(-antigen-parse-args \
            'url?, loc? ; branch:?, no-local-clone?, btype:?' \
            "$@")"

    # Resolve the url.
    url="$(-antigen-resolve-bundle-url "$url")"

    # Add the branch information to the url.
    if [[ ! -z $branch ]]; then
        url="$url|$branch"
    fi

    local make_local_clone=true
    if [[ $url == /* && -z $branch &&
            ( $no_local_clone == true || ! -d $url/.git ) ]]; then
        make_local_clone=false
    fi

    # Add it to the record.
    _ANTIGEN_BUNDLE_RECORD="$_ANTIGEN_BUNDLE_RECORD\n$url $loc $btype"
    _ANTIGEN_BUNDLE_RECORD="$_ANTIGEN_BUNDLE_RECORD $make_local_clone"
    echo $_ANTIGEN_BUNDLE_RECORD > $ADOTDIR/antigen_bundle_record

    # Ensure a clone exists for this repo, if needed.
    if $make_local_clone; then
        -antigen-ensure-repo "$url"
    fi

    # Load the plugin.
    echo "$(-antigen-echo "$url" "$loc" "$make_local_clone")"

}

-antigen-echo () {

    local url="$1"
    local loc="$2"
    local make_local_clone="$3"

    # The full location where the plugin is located.
    local location
    if $make_local_clone; then
        location="$(-antigen-get-clone-dir "$url")/"
    else
        location="$url/"
    fi

    [[ $loc != "/" ]] && location="$location$loc"

    if [[ -f "$location" ]]; then
        echo "$location"

    else
        echo ""

    fi

}
