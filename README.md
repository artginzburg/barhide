<div align="center">

  # barhide
  **CLI to hide unwanted icons from your** macOS **menu bar**
</div>

## Usage

```powershell
barhide [-hV] [options] <app>|<bundle_id>
        [-u,  --update]    # Check for update and ask to install
      # Options:
      	[-f,  --force]     # Force preference change
```

## Install · [![GitHub release](https://img.shields.io/github/release/artginzburg/barhide?label=%20&color=gray)](//github.com/artginzburg/barhide/releases)

### Via :beer: [Homebrew](https://brew.sh)

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

<br />

## Well... Why?

Usually, you hide excessive items from the status bar like this:

1. Holding `⌘ [CMD]`, drag it away from your menu bar until you see a :heavy_multiplication_x: (cross icon)
2. Let it go

> To recover the icon, simply reopen the app when it's already running (in most third-party applications)

But in some <b>cases</b><sup>*</sup>, unwanted icons can't be hidden like that. At this moment `barhide` appears.

<sup>*</sup> like [Magnet](https://magnet.crowdcafe.com), or Spotlight and Notification Center prior to Big Sur
