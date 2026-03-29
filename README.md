# baressg

A barebones static site generator. For more features, look into [Zola](https://github.com/getzola/zola), [Hugo](https://github.com/gohugoio/hugo), or [Jekyll](https://github.com/jekyll/jekyll).

## Features
- Converts Markdown to HTML using [lowdown](https://kristaps.bsd.lv/lowdown/)
- Generates clean URL slugs (`src/about.md` → `out/about/index.html`)
- Prunes deleted files
- Optional back button (`make BACK=1`)
- Specify CSS in makefile (uses [Simple.css](https://simplecss.org/) by default)

## Requirements

- GNU make (`make` on Linux/macOS, `gmake` on BSD)
- [lowdown](https://kristaps.bsd.lv/lowdown/)

## Usage

```sh
make         # build src/ into out/
make BACK=1  # build with back button
make clean   # remove out/
make re      # clean + build
make example # demo example/ in browser
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
