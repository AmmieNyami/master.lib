#!/bin/sh

set -e

if [ -z "$WATCOM" ]; then
    echo "ERROR: \$WATCOM environment variable not set" >&2
    exit 1
fi

MASTER_MEMORY_MODEL="${MASTER_MEMORY_MODEL:=NEAR}"

_MEMORY_MODEL=""
_CALL_MODEL=""
_OUTPUT_LIB=""

case "$MASTER_MEMORY_MODEL" in
    NEAR|near)
        _MEMORY_MODEL=NEARMODEL
        _CALL_MODEL=NEAR
        _OUTPUT_LIB=masters.lib
        ;;
    FAR|far)
        _MEMORY_MODEL=FARMODEL
        _CALL_MODEL=FAR
        _OUTPUT_LIB=masterl.lib
        ;;
    COMPACT|compact)
        _MEMORY_MODEL=COMPACTMODEL
        _CALL_MODEL=NEAR
        _OUTPUT_LIB=masterc.lib
        ;;
    MEDIUM|medium)
        _MEMORY_MODEL=MEDIUMMODEL
        _CALL_MODEL=FAR
        _OUTPUT_LIB=masterm.lib
        ;;
    *)
        echo "ERROR: unrecognized memory model \`$MASTER_MEMORY_MODEL\`" >&2
        exit 1
        ;;
esac

export PATH=$WATCOM/binl:$PATH
export EDPATH=$WATCOM/eddat
export WIPFC=$WATCOM/wipfc
export INCLUDE=$WATCOM/h
export LIB=$WATCOM/lib286/dos

function uasm() {
    echo uasm $@
    command uasm $@
}

function wlib() {
    echo wlib $@
    command wlib $@
}

pushd src > /dev/null 2>&1

# Build assembly files
for file in *.asm; do
    out_file=$(basename "$file" .asm).o
    if [ "$file" -nt "$out_file" ]; then
        uasm -q -DVERSIONSTR="\"0.23\"" -D$_MEMORY_MODEL -DCALLMODEL=$_CALL_MODEL -Fo"$out_file" "$file"
    fi
done

# Build final .lib file
lib_needs_rebuild=false
for file in *.o; do
    if [ "$file" -nt ../$_OUTPUT_LIB ]; then
        lib_needs_rebuild=true
        break
    fi
done
[ $lib_needs_rebuild = true ] && wlib -q -n ../$_OUTPUT_LIB *.o

popd > /dev/null 2>&1

echo "==> DONE! Generated ./$_OUTPUT_LIB"
