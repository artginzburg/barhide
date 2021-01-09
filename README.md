<div align="center">
	<h1>barhide</h1>
  <p><b>CLI to hide unwanted icons from your </b>macOS<b> menu bar</b></p>
</div>

## Usage

```powershell
barhide [-hV] [options] <app>|<bundle_id>
        [-u,  --update]    # Check for update and ask to install
      # Options:
      	[-f,  --force]     # Force preference change
```

- Notification Center icon is controlled by `SystemUIServer`

## Install · [![GitHub release](https://img.shields.io/github/release/dafuqtor/barhide?label=%20&color=gray)](//github.com/DaFuqtor/barhide/releases)

### Using :beer: [Homebrew](//brew.sh)

```powershell
brew install artginzburg/tap/barhide
```

### Using `curl`

```powershell
curl -sL raw.githubusercontent.com/artginzburg/barhide/master/install.sh | sh
```

### Using Source Code

```powershell
git clone https://github.com/artginzburg/barhide
cd barhide
make
```

> Also allows to `make [ upgrade, uninstall ]`

### Well... Why?

Usually, you hide excess items from the status bar like this:

1. Holding `⌘`, drag it away from the status bar until you see a :heavy_multiplication_x: (cross icon)
2. Let it go

> To recover the icon, simply reopen the app when it's already running (in most third-party applications)

But in some <b>cases</b><sup>*</sup>, unwanted icons can't be hidden like that. At this moment `barhide` appears.

<sup>*</sup> Spotlight, Notification Center, [Magnet](//magnet.crowdcafe.com)
