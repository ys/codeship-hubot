##Hubot scripts for postgres dataclips
**Postgres heroku dataclips for Hubot**

### Installation

Add the repository to your hubot's package.json:

```
dependencies: {
  "dataclips-hubot": "git://github.com/ys/dataclips-hubot.git"
}
```

Include the package in your hubot's external-scripts.json

```
["dataclips-hubot"]
```

### TODO

- Better support of complex values (for the moment mostly a simply string interpolation)

### License

See LICENSE file.