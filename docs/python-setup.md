# Python setup on macOS

This project requires Python 3.13. CI, the local virtual environment, and the
Docker base image use the same minor version. `.python-version` records `3.13`
for tools that support version selection.

Use one interpreter manager for new work. This Mac uses
[uv-managed Python](https://docs.astral.sh/uv/guides/install-python/), with tools
and interpreter links in `~/.local/bin`. Existing Homebrew interpreters remain
available through their explicit versioned paths. Apple's `/usr/bin/python3`
is left intact.

```bash
uv python install 3.13 --default
python3.13 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m pip check
python -m pytest -v
```

Confirm the active interpreter and package installer:

```bash
command -v python python3 pip
python --version
python -m pip --version
```

After activation, paths should point into this project's `.venv`, and the Python
version should be 3.13.x. In VS Code, select `.venv/bin/python` through
**Python: Select Interpreter**. The local workspace settings select this path
and enable pytest discovery in `tests/`.

Use a separate `.venv` for each project. Deactivate it before switching projects:

```bash
deactivate
```

When an environment was created with the wrong Python version, preserve any
needed package list and recreate that project's environment using the required
interpreter. Changing shell PATH does not change an existing venv's interpreter.
Install application packages inside venvs, and install standalone Python tools
with `uv tool install <tool>`.

The shell configuration in `~/.config/python/shell.zsh` is sourced by `.zprofile`
and `.zshrc`; it puts `~/.local/bin` first outside a venv, deduplicates PATH, and
keeps an activated venv first. The `pip` and `pip3` wrappers outside a venv invoke
`python3 -m pip`, keeping the installer paired with the selected interpreter.
