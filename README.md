# baressg

A minimal static site generator from Markdown files using Make and [lowdown](https://kristaps.bsd.lv/lowdown/).

## Requirements

- `make`
- `lowdown`

## Usage

```sh
make         # build src/ into out/
make BACK=1  # add optional back button
make clean   # remove out/
make re      # clean + build
make example # copy example/ into src/ and build
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
