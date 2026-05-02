# dotfiles

This repo is intended to hold and sync env configuration for my Mac machines.

## Bootstrap

Run the machine setup with:

```sh
./configure.sh -t home
```

Use `-t work` on work machines to include the work-only package and skill lists.

## Spec Kit

`configure.sh` installs GitHub Spec Kit's Specify CLI as a persistent `pipx` tool, pinned by `SPEC_KIT_VERSION` in the script. This intentionally installs from `github/spec-kit` instead of PyPI, matching the upstream guidance for official builds.

To start using it in a personal project with Codex skills:

```sh
specify init --here --integration codex --integration-options="--skills"
specify check
```
