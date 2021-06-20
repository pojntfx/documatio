# documatio

In goes Markdown, out come indexed HTML and PDF slides and documents.

## Overview

documatio is a strongly opinionated tool which takes in Markdown as a single source of truth and transforms it to slides and documents in PDF and HTML format, ready to be published to GitHub pages or a similar CDN.

## Installation

Before continuing, make sure to install [pandoc](https://pandoc.org/) and [inotify-tools](https://github.com/inotify-tools/inotify-tools/wiki) on your system.

To install `documatio`, run the following:

```shell
$ curl https://raw.githubusercontent.com/pojntfx/documatio/main/documatio | bash -s -- upgrade
```

Works on Linux, macOS and Windows (WSL2). Now, continue to [Usage](#usage) to create your first instance.

## Usage

🚧 This project is a work-in-progress! Better instructions will be added as soon as it is usable. 🚧

documatio takes all files from a `docs` directory and compiles them into the `out` directory. It also requires a `docs/metadata.txt` file with contents like the following:

```plaintext
Uni DB1 Notes
Personal notes for the DB1 course at HdM Stuttgart.
© 2021 Felicitas Pojtinger under AGPL-3.0
https://github.com/pojntfx/uni-db1-notes
https://github.com/pojntfx/uni-db1-notes/releases/latest/download/all.zip
📎 Happy persisting!
```

The first line is the title, second title the description, third one is the license header, fourth one the URL to the source, fifth a link to download everything at once and the last one is the footer.

It is also recommended to use a GitHub action to set up automatic builds at `.github/workflows/documatio.yaml` with the following contents:

```yaml
name: documatio CI

on: [push, pull_request]

jobs:
  make:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2
      - name: Install dependencies
        run: |
          sudo apt update
          sudo apt install -y pandoc texlive curl
      - name: Set up documatio
        run: curl https://raw.githubusercontent.com/pojntfx/documatio/main/documatio | bash -s -- upgrade
      - name: Compile Markdown
        run: documatio build
      - name: Publish to GitHub releases
        if: ${{ github.ref == 'refs/heads/main' }}
        uses: marvinpinto/action-automatic-releases@latest
        with:
          repo_token: "${{ secrets.GITHUB_TOKEN }}"
          automatic_release_tag: "latest"
          prerelease: false
          files: |
            out/release/all.zip
      - name: Publish to GitHub pages
        if: ${{ github.ref == 'refs/heads/main' }}
        uses: JamesIves/github-pages-deploy-action@4.1.0
        with:
          branch: gh-pages
          folder: out/docs
          git-config-name: GitHub Pages Bot
          git-config-email: bot@example.com
```

Here are all the available options:

```shell
$ documatio --help
In goes Markdown, out come indexed HTML and PDF slides and documents.

Utility Commands:
build                               Build the files in the `docs` directory into the `out` directory.
dev                                 Re-compile if a Markdown file in the `docs` directory changes.

Miscellaneous Commands:
upgrade                             Upgrade this tool.

For more information, please visit https://github.com/pojntfx/documatio#Usage.
```

## Updates

`documatio` includes a self-update tool, which you can invoke by running the following:

```shell
$ documatio upgrade
```

## License

documatio (c) 2021 Felicitas Pojtinger and contributors

SPDX-License-Identifier: AGPL-3.0
