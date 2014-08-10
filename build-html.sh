#!/bin/bash
#
# NOTE: to clear all generated html files, run:
#   rm -f ./*.html
#

# env
DIR=$(pwd)
TODO='*.md'
EXT='html'
MDE=$(which markdown-extended)

# help
if [ "$1" == '-h' ]||[ "$1" == '--help' ]||[ "$1" == 'help' ]; then
    echo 
    echo "usage:  $0  <MD_files [=*]>  <output_extension [=html]>  <mde_bin_path [='markdown-extended']>"
    echo
    echo "options:"
    echo "          MD_files:           Markdown content(s) to parse"
    echo "                              default is '*': all '.md' files"
    echo "          output_extension:   the extension to build output file(s)"
    echo "                              default is 'html'"
    echo "          mde_bin_path:       path to the MarkdownExtended binary to use"
    echo "                              default is '${MDE}'"
    echo
    exit 0
fi

# options
[ $# -gt 0 ] && TODO="$1";
[ $# -gt 1 ] && EXT="$2";
[ $# -gt 2 ] && MDE="$3";

# todo is valid ?
if [ "${TODO}" == '' ]; then
    echo "error: MD files mask seems empty!"
    exit 1
# todo is wildcard ?
elif [ "${TODO}" == '*' ]; then
    TODO='*.md'
fi

# extension is valid ?
if [ "${EXT}" == '' ]; then
    echo "error: output extension seems empty! (this would overwrite sources)"
    exit 1
fi

# mde bin is valid ?
if [ -z ${MDE} ]||[ ! -f ${MDE} ]; then
    echo "error: MDE binary not found! (searching '${MDE}')"
    exit 1
fi

# let's go
for f in $(ls ${DIR}/${TODO}); do
    ${MDE} -b ${f} > ${f/.md/.${EXT}};
    if [ $? -eq 0 ]; then
        echo "${f} -> ${f/.md/.${EXT}}";
    fi
done

# done
echo "_ ok"
