# Lerna

> That creature, bred in the swamp of Lerna, used to go forth into the plain
> and ravage both the cattle and the country. Now the hydra had a huge body,
> with nine heads, eight mortal, but the middle one immortal.

[Bibliotheca](http://www.perseus.tufts.edu/hopper/text?doc=Perseus%3Atext%3A1999.01.0022%3Atext%3DLibrary%3Abook%3D2%3Achapter%3D5%3Asection%3D2)

## What

Lerna is a tool to make itinerant computing easier.
It watches for changes to the connected displays and configures X.org to use
what it deems to be the best display.

If

* you use a Linux laptop,
* you use an external monitor, and
* you want to use a single display at a time

then Lerna might be useful to you.
If you want to use multiple displays, it won't be immediately useful, but it
might still be a good starting point.

## How

```sh
$ lerna
```

You'll see output something like this:

    [2014-08-02T04:10:06.592689Z #13059] Switching to DP2
    [2014-08-02T04:11:17.008609Z #13059] DP2 => disconnected
    [2014-08-02T04:11:17.008764Z #13059] Switching to LVDS1
    [2014-08-02T04:11:21.521592Z #13059] DP2 => connected
    [2014-08-02T04:11:21.521679Z #13059] Switching to DP2

To see more options, use:

```sh
$ lerna --help
```

An example Upstart script for Ubuntu (pre-15.04) is provided in the `support`
directory.
This assumes that `lerna` is in the path; if it's not, you'll need to adjust
this.

You can then use

```sh
$ start lerna
```

to start the job immediately; it should start and stop automatically with your
desktop session thereafter.

## Wanted

* Example job for systemd
* More strategies
* Ability to read from a configuration file (and reload on change)
