# scoop-whoisport

[Scoop](https://scoop.sh) bucket for [whoisport](https://github.com/dpologdvinity/whoisport),
a command-line tool that shows what is listening on a port and can stop it safely.

```powershell
scoop bucket add whoisport https://github.com/dpologdvinity/scoop-whoisport
scoop install whoisport
```

The manifest (`bucket/whoisport.json`) is updated automatically: a scheduled workflow
(`.github/workflows/update.yml`) checks for a new whoisport release every six hours and
points the manifest at it, using the release's published SHA-256 digest.

Issues with the tool itself belong in the
[whoisport repository](https://github.com/dpologdvinity/whoisport/issues).

License: MIT, like whoisport.
