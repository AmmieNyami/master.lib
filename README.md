# master.lib

An abstraction layer for low level PC-98x1, DOS/V and PC/AT stuff, or, as the original authors say, 「なんだかわからんがごちゃごちゃ入ってるライブラリ」.

Originally written by Akihiko Koizuka (@koizuka), Hitoshi Okuda, Yuji Chino and Takashi Sawa. Modified by @AmmieNyami to be compilable from Linux.

The original library can be found at <https://www.koizuka.jp/~koizuka/master.lib/>.

The library's development history can be found at [./master.his](./master.his). The library's documentation can be found at [./docs](./docs). The library's C header files can be found at [./include](./include).

All versions of the library (small, large, compact and medium) are buildable. Though, I've only tested the small version.

## Building

The build script is written to be ran on Linux.

For building, you will need to have [`uasm`](https://www.terraspace.co.uk/uasm.html) available in your `$PATH`, and the `WATCOM` environment variable set to the path of a directory containing an [OpenWatcom](https://open-watcom.github.io/) distribution. Having these requirements met, you can build the library by running:

```console
$ ./build.sh                             # to build the small version
$ MASTER_MEMORY_MODEL=FAR ./build.sh     # to build the large version
$ MASTER_MEMORY_MODEL=COMPACT ./build.sh # to build the compact version
$ MASTER_MEMORY_MODEL=MEDIUM ./build.sh  # to build the medium version
```

Running one of these commands will generate a `.lib` file that you can link with.
