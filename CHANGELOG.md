<!-- markdownlint-disable MD024 no-duplicate-heading -->

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

**Types of changes**: `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`

## [Unreleased]

---

## [0.2.0] - 2026-03-29

### Added

- Makefile with `package`, `install`, `png`, `clean` targets for vsix builds
- Auto-generated vsix README with PNG screenshots (absolute GitHub raw URLs)
- Direct `curl` install from GitHub Releases in README
- Build section in README
- Bump and Release GHA workflow with vsix artifact upload
- Dependabot for npm + GitHub Actions
- CodeQL security scanning

### Changed

- Unified light/dark screenshot SVGs into single files with `prefers-color-scheme`
- Wrapped README screenshots in `<details><summary>` for collapsible previews
- Moved variants table below screenshot previews
- Darkened Green Dark foreground (`#A8D4A2` → `#8CB888`), strengthened hover effects
- Split `assets/images/` into `assets/logos/` and `assets/screenshots/`
- Makefile version derived dynamically from `package.json`
- Bumpversion config in `pyproject.toml` (was `.bumpversion.toml`)

### Removed

- `.vscode/launch.json` (unused for theme extension)
- Static `README.vsix.md` (now auto-generated)

## [0.1.0] - 2026-03-28

### Added

- EyeRest Dark — warm umber bg, yellow-green-amber accents, zero blue
- EyeRest Light — warm parchment bg, deep earth accents, zero blue
- EyeRest Green Dark — deep forest bg, all-green palette, green text
- EyeRest Green Light — yellow-green bg, dark green text, minimal blue
- EyeRest BluBlock Dark — zero-blue palette for 100% blue-blocking goggles
- EyeRest BluBlock Light — warm parchment, zero-blue syntax for goggles
- EyeRest Dusk Dark — plum-gray bg, earth-tone accents
- EyeRest Dusk Light — pale sage bg, earth-tone accents
- Semantic highlighting for all themes
- Full 16-color ANSI terminal palette per theme
- Bracket pair colorization (6 colors)
- 5 logo options (SVG + PNG)
- Scientific sources in README
