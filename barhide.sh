#!/usr/bin/env sh

VERSION=0.1.0
CMD='barhide'

name=
app=
id=
rdAble=
invis=
force=

usage() {
  cat <<EOF

  Usage: $CMD [-hV] [options] <app>|<bundle_id>
    $CMD SystemUIServer to hide the notification centre icon

  Options:
    -f,  --force      Force preference change
    -V,  --version    Output version
    -u,  --update     Check for update and ask to install
    -h,  --help       This message.

EOF
}

barhide() {
	if ! [ "$1" ]; then
		usage
		return 0
	fi
  for opt in "${@}"; do
    case "$opt" in
      -h|--help)
        usage
        return 0
        ;;
      -V|--version)
        echo "$VERSION"
        return 0
        ;;
      -u|--update)
        echo "$CMD $VERSION"
        printf "  Checking for the update...\r"
        gitver=$(curl -s https://api.github.com/repos/DaFuqtor/$CMD/releases/latest | grep tag_name | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | tr -d '[:space:]')
        if [ "$gitver" = "$VERSION" ]; then
          echo "  Already up to date.       "
        else
          if [ "$gitver" ]; then
            echo "  Latest version is $gitver     "
            read -r -p "Do you want to update? [Enter/Ctrl+C]" response
            if [[ $response =~ ^( ) ]] || [[ -z $response ]]; then
              if command -v brew > /dev/null && brew list "$CMD" &> /dev/null; then
                 brew upgrade "$CMD"
              else
                echo "\n - Downloading latest $CMD ($gitver)"
                curl -sL raw.githubusercontent.com/DaFuqtor/"$CMD"/master/install.sh | sh && echo " - Update completed!\n"
              fi
            else
              echo "  Enjoy the outdated $CMD"
            fi
          else
            echo "  Couldn't check for update!"
            wifi_interface=$(networksetup -listallhardwareports | grep -A 1 Wi-Fi | grep Device | awk '{print $2}')
            if [ "$(networksetup -getairportpower "$wifi_interface" | awk '{print $4}')" = "Off" ]; then
              read -r -p "Wi-Fi Adapter is disabled. Maybe you should consider turning it on? [Enter/Ctrl+C]" response
              if [[ $response =~ ^( ) ]] || [[ -z $response ]]; then
                networksetup -setairportpower "$wifi_interface" On && sleep 1 && $CMD "${@}"
              fi
            fi
            exit 1
          fi
        fi
        return 0
        ;;
      -f|--force)
        force=1
        ;;
      *)
        if [ "$name" ]; then
          name="$name $opt"
        else
          name="$opt"
        fi
    esac
  done

  if [ $(mdfind kMDItemCFBundleIdentifier = "$name") ]; then
  	# given bundle id instead of app, get its path
  	app=$(mdfind kMDItemCFBundleIdentifier = "$name")
  	id=$name
  fi

  if ! [ "$app" ]; then
	  # search for the app
	  app=$(mdfind -onlyin /Applications/ -onlyin /System/Library/CoreServices/ "(kMDItemContentTypeTree=com.apple.application) && (kMDItemDisplayName == '$name*'cdw)" | head -1)
	fi

  rdAble=$(basename -s .app "$app")

  if [ "$rdAble" ]; then

    if ! [ "$id" ]; then
      # fast (0.01s-0.02s)
      id=$(/usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier' "$app"/Contents/Info.plist)
    fi

    if ! [ "$id" ]; then
      # Search for partial match ~4x slower than PlistBuddy
      id=$(mdls -name kMDItemCFBundleIdentifier -raw "$app")
    fi

    if ! [ "$id" ]; then
      # ~8x slower than PlistBuddy
      id=$(osascript -e 'id of app "$app"')
    fi

    if ! [ "$id" ]; then
      # Search in running apps, ~2x slower than PlistBuddy
      id=$(lsappinfo info -only bundleid "$rdAble" | cut -d '"' -f4)
    fi

  else
    echo "No app with this name"
    exit 1
  fi

  if defaults read "$id" "NSStatusItem Visible Item-0" &> /dev/null; then
	  if [[ $(defaults read "$id" "NSStatusItem Visible Item-0") = 0 ]]; then
	    invis=1
	  fi
	else
		if ! defaults read "$id" "NSStatusItem Preferred Position Item-0" &> /dev/null; then
			echo "Seems like the \"$rdAble\" app has no status item at all"
      if [ "$force" ]; then
        echo 'Forcing preference change...'
      else
        echo 'To force showing/hiding this status icon, use -f flag'
  			exit 1
      fi
		fi
  fi

  printf "$rdAble with id $id was found in $app and "

  if [ "$invis" ]; then
  	defaults delete "$id" "NSStatusItem Visible Item-0" && \
  	echo "shown"
  else
  	defaults write "$id" "NSStatusItem Visible Item-0" 0 && \
  	echo "hidden"
  fi

  if pgrep "$rdAble" > /dev/null; then
    killall "$rdAble" &> /dev/null
    if ! echo "$app" | grep /System/Library/CoreServices/ > /dev/null; then
    	# App is not from Core, so it's not relaunching itself. Do relaunch
	    if ! pgrep "$rdAble" > /dev/null; then
	    	# LSOpenURLsWithRole() failed for the application /System/Library/CoreServices/Spotlight.app with error -600.
	    	# rare error appears on opening.
	      open -a "$rdAble"
	    fi
	  fi
  fi

}

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f $CMD
else
  $CMD "${@}"
  exit $?
fi