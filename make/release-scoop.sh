#!/bin/bash

function main() {
    local ZIP="../archive/zx42tools.zip"
    local JSON="../bucket/zx42tools.json"

    cd bin || return 11

    rm -f "${ZIP}"    || return 12
    7z a "${ZIP}" *   || return 13
    local SHA=$(
        sha256sum "${ZIP}" \
        | sed -e 's/ .*//'
    )

    cat > tools.yaml <<EOF
SHA: ${SHA}
BINS:
EOF

    for fexe in *.exe ; do
        echo "  - ${fexe}" >> tools.yaml
    done

    goplate apply                               \
        --template=../make/tools.gplt.json      \
        --output="${JSON}"                      \
        --data=tools.yaml                       \
        --delimiters="/*,*/"
}

main "$@" || exit $?
