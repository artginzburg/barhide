<div align="center">
	<h1>barhide</h1>
	<p><b>CLI to hide unwanted icons from your menu bar</b></p>
</div>

## Usage

```powershell
barhide [-hV] [options] <app>|<bundle_id>
        [-u,  --update]    # Check for update and ask to install
      # Options:
      	[-f,  --force]     # Force preference change
```

- barhide SystemUIServer to hide the notification centre icon

## Install · [![GitHub release](https://img.shields.io/github/release/dafuqtor/barhide?label=%20&color=gray)](//github.com/DaFuqtor/barhide/releases)

### Using :beer: [Homebrew](//brew.sh)

```powershell
brew install dafuqtor/tap/barhide
```

### Using `curl`

```powershell
curl -sL raw.githubusercontent.com/DaFuqtor/barhide/master/install.sh | sh
```

### Using Source Code

```powershell
git clone https://github.com/DaFuqtor/barhide
cd barhide
make
```

> Also allows to `make [ upgrade, uninstall ]`
