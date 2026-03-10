# Contributing to forge

Thanks for taking the time to contribute. This document covers everything you need to know before opening a PR or filing an issue.

---

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Commit Message Format](#commit-message-format)
- [Versioning & Release Flow](#versioning--release-flow)
- [Style Rules](#style-rules)
- [Testing](#testing)
- [Reporting Bugs](#reporting-bugs)
- [Suggesting Features](#suggesting-features)

---

## Code of Conduct

Be respectful. Harassment, personal attacks, or exclusionary language will not be tolerated.

---

## Getting Started

```bash
git clone https://github.com/scott-lexium/forge.git
cd forge
sudo bash install.sh          # installs from local source
sudo forge help
```

No build step. The entire project is a single Bash script (`forge`) and an installer (`install.sh`).

---

## How to Contribute

1. **Fork** the repo and create a branch from `main`
2. **Make your changes** following the style rules below
3. **Test** on a fresh Ubuntu 22.04 VM before opening a PR
4. **Commit** using the [Conventional Commits](#commit-message-format) format
5. **Open a pull request** against `main` with a clear description of what changed and why

Small, focused PRs are preferred over large ones that touch many phases at once.

---

## Commit Message Format

This project uses [Conventional Commits](https://www.conventionalcommits.org/). Every commit on `main` is parsed to auto-generate the changelog and determine the next version number — so the format matters.

### Structure

```
<type>(<optional scope>): <short description>

[optional body]

[optional footer — BREAKING CHANGE: ...]
```

### Types

| Type | When to use | Version bump |
|---|---|---|
| `feat` | New feature or new wizard phase | minor |
| `fix` | Bug fix | patch |
| `perf` | Performance improvement | patch |
| `revert` | Reverts a previous commit | patch |
| `docs` | Documentation only | none |
| `chore` | Build, CI, dependencies, tooling | none |
| `refactor` | Code restructure, no behaviour change | none |
| `test` | Adding or fixing tests | none |

For a **breaking change** (e.g. changes to the CLI interface or config format), add `!` after the type or include `BREAKING CHANGE:` in the commit footer. This triggers a major version bump.

### Examples

```
feat(ssh): add FIDO2/hardware key support in phase 3
fix(sysctl): prevent duplicate entries on re-run
fix(phase3): validate SSH public key format before applying
feat!: rename --port flag to --ssh-port (breaking CLI change)
chore(ci): tighten shellcheck severity to warning
docs: add troubleshooting section to README
refactor(ufw): extract port-open logic into helper function
```

### Rules

- Use the **imperative mood** in the description: "add", "fix", "remove" — not "added", "fixes", "removed"
- Keep the first line under **72 characters**
- Don't capitalise the first word after the colon
- No full stop at the end of the subject line
- Reference issues in the footer: `Closes #42`

---

## Versioning & Release Flow

This project follows [Semantic Versioning](https://semver.org/) (`MAJOR.MINOR.PATCH`).

**You never manually edit the version number or `CHANGELOG.md`.** Both are managed automatically:

1. Commits land on `main`
2. [release-please](https://github.com/googleapis/release-please) opens a Release PR that bumps the version in the `forge` script and updates `CHANGELOG.md`
3. A maintainer reviews and merges the Release PR
4. release-please creates a git tag and GitHub Release automatically

If your PR is a `fix:` it will be included in the next patch release. If it is a `feat:` it will be included in the next minor release. `chore:` and `docs:` commits are grouped into the release notes but do not trigger a new release on their own.

---

## Style Rules

This is a Bash script. Readability and safety matter more than cleverness.

### Mandatory

- `set -euo pipefail` and `IFS=$'\n\t'` are already set — do not remove them
- Quote all variable expansions: `"$VAR"`, `"${ARRAY[@]}"`, `"$(subshell)"`
- Use `[[ ]]` for conditionals, not `[ ]`
- Never use `eval` for new code — use `printf -v varname` for indirect assignment
- Validate user input before acting on it
- Prefer `run <command>` (the existing wrapper) over bare commands — it logs and handles errors consistently

### Phases

- Each phase must be idempotent — running it twice must produce the same result as running it once
- Check for existing state before making changes (e.g., "package already installed", "user already exists")
- Always back up config files before overwriting them (see the `sshd_config.bak` pattern in phase 3)
- Print a clear `ok "Phase N complete"` at the end of every phase

### Output

- Use the existing helpers: `info`, `ok`, `warn`, `error`, `note`, `skip` — do not use raw `echo` for status messages
- `error` exits the script — use it only for unrecoverable failures
- `warn` does not exit — use it for recoverable problems or skipped steps

### Shellcheck

All code must pass [ShellCheck](https://www.shellcheck.net/) at `error` severity. CI will block your PR if it doesn't. You can run it locally:

```bash
shellcheck forge install.sh
```

---

## Testing

There is no automated test suite yet. Before submitting a PR, manually test your changes on a **fresh Ubuntu 22.04 LTS VM** (a local VM, VPS, or container works).

For phase changes, test:
- Running only that phase in isolation: `sudo forge phase N`
- Running all phases end-to-end: `sudo forge`
- Running the phase a second time (idempotency)
- `sudo forge status` still reports correctly after the phase

---

## Reporting Bugs

Open an [issue](https://github.com/scott-lexium/forge/issues) and include:

- The full command you ran
- The relevant output (paste it — don't screenshot terminal text)
- The log file from `/var/log/forge/` if applicable
- Ubuntu version: `lsb_release -ds`
- forge version: `sudo forge version`

---

## Suggesting Features

Open an issue with the `enhancement` label. Describe:

- What problem it solves (not just what you want)
- Which phase it belongs to, or whether it is a new phase
- Whether it would require user interaction or can run unattended

Features that increase the script's complexity significantly without broad applicability are unlikely to be merged. Smaller, composable improvements are preferred.
