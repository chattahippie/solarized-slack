# solarized-slack

Solarized (dark) theme for slack that includes the message elements instead of just the sidebar.

![solarized slack](images/solarized.png "Solarized Screenshot")

## Quick Start

1. Download Slack. This can be done through brew:

```sh
brew cask install slack
```

2. Open Slack.
3. Open a terminal and run the command

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/chattahippie/solarized-slack/master/scripts/solarize-slack.sh)"
```

4. Reload Slack (CMD-R)
5. Enjoy!

## How it works

This fork of solarized-slack installs a hook into Slack's code to inject CSS into the main window. The CSS that is used is also downloaded into the client, so no files are downloaded when Slack is opened.

## References

- The CSS is based on [laCour/slack-night-mode](https://github.com/laCour/slack-night-mode)
- The CSS is compiled from [chattahippie/slack-night-mode](https://github.com/chattahippie/slack-night-mode)
- Hex values from [solarized cheat sheet](http://www.zovirl.com/2011/07/22/solarized_cheat_sheet/)
- [glostis](https://github.com/laCour/slack-night-mode/pull/188) for the solarized-dark theme for slack-night-mode
