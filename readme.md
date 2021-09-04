# Macbook Dotfiles for Magento Development

## Table of Contents

## Requirements

In general this is written for Mac so we'll assume you have one of those, 
you should have the following installed.

- [Magento Cloud CLI Tool (if you use Magento Cloud)](https://devdocs.magento.com/cloud/reference/cli-ref-topic.html)
- ZSH (recommend [Oh My ZSH](https://ohmyz.sh/))
- [NodeJS](https://nodejs.org/en/)
- [ImageOptim](https://imageoptim.com/mac) (for the Image functions)

## Installation

Clone the repo to your prefered directory and run the following command:

```bash
$: sh setup.sh
```

This will install 2 additional apps [ansi](https://github.com/fidian/ansi) and [Google Lighthouse](https://github.com/GoogleChrome/lighthouse) if you don't already have them.

Echos a bunch of information to `~/.zprofile` which you should source in your `.zshrc` file with:

```bash
source ~/.zprofile
```

## Aliases

| Command       | Alias for or Purpose                                                         |
|---------------|------------------------------------------------------------------------------|
| `recomposer`  | `composer install`                                                           |
| `zrefresh`    | `source ~/.zshrc`                                                            |
| `zrf`         | `zrefresh`                                                                   |
| `n98`         | `n98-magerun2.phar`                                                          |
| `n98-magerun` | `n98-magerun2.phar`                                                          |
| `bmage`       | `n98` if that's set as your `$MAGENTO_CLI_TOOL` default is `php bin/magento` |
| `magec`       | `magento-cloud`                                                              |
| `bmage-cache` | `bmage cache:flush`                                                          |
| `bmage-dev`   | `m2-start-development`                                                       |
| `bmage-fixes` | `m2-fixes`                                                                   |
| `bmage-local` | `m2-setup-local`                                                             |
| `magec-db`    | `m2getcloudbdb`                                                              |
| `magec-media` | `m2getcloudmedia`                                                            |
| `magec-ssh`   | `m2cloudssh`                                                                 |

## Functions