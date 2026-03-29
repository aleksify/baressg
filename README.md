# baressg

A minimal static site generator from Markdown documents using Make and [lowdown](https://kristaps.bsd.lv/lowdown/).

## Features
- Automatically creates folder structure
- Prunes deleted files
- Optional back button
- Generates HTML from Markdown using `lowdown`

## Requirements

- `make`
- `lowdown`

## Usage

```sh
make         # build src/ into out/
make BACK=1  # build with back button
make clean   # remove out/
make re      # clean + build
make example # copy example/ into src/, build with BACK=1, and open in the browser
```

## Example Structure

```
src/
  index.md          → out/index.html
  about.md          → out/about/index.html
  blog.md           → out/blog/index.html
  blog/
    md-guide.md     → out/blog/md-guide/index.html
    madeira.md      → out/blog/madeira/index.html
```

- `src/index.md` is treated specially — it outputs to `out/index.html` directly
- All other `.md` files become `out/<slug>/index.html`
- Stale output files are pruned automatically on each build

## Styling

Uses [Simple.css](https://simplecss.org/) by default. Change the `CSS` variable in the Makefile to use your own.
