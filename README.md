# SDI 4213 – Weeks 5–6 Individual Exercise Starter

This repository is the starter project for the **Weeks 5–6 Individual Exercise** in **SDI 4213-980: DevOps – CI/CD**.

You will extend a working CI project by adding two major capabilities:

1. **Week 5 – Build and Release Automation**
   - preserve the existing automated tests
   - create a packaged ZIP build artifact
   - upload the artifact from GitHub Actions
   - use the `VERSION` file
   - create a Git tag
   - create a GitHub Release
   - document the release in `CHANGELOG.md`

2. **Week 6 – Docker Containerization**
   - complete the starter `Dockerfile`
   - complete `.dockerignore`
   - build a versioned Docker image
   - run the container
   - publish port 8000
   - verify `/health`
   - inspect logs
   - stop and remove the container

## Repository Structure

```text
.
├── .github/
│   ├── ISSUE_TEMPLATE/
│   ├── workflows/
│   │   └── ci.yml
│   └── PULL_REQUEST_TEMPLATE.md
├── app/
├── tests/
├── docs/
│   ├── evidence-template.md
│   └── Weeks5_6_Individual_Exercise.docx
├── student-resources/
│   └── Dockerfile_hints.md
├── .dockerignore
├── .env.example
├── .gitignore
├── CHANGELOG.md
├── Dockerfile
├── README.md
├── VERSION
└── requirements.txt
```

## Before You Begin

Use Python **3.13**, matching CI and the Docker base image. Create and activate a
project virtual environment; install packages with `python -m pip` so they belong
to the selected interpreter. See [Python setup](docs/python-setup.md) for macOS
environment management.

### macOS / Linux Terminal

```bash
python3.13 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python -m pytest -v
```

### Windows PowerShell

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
```

Run the automated tests:

```powershell
python -m pytest -v
```

The starter project should pass all tests before you make Week 5 or Week 6 changes.

Run the application locally:

```powershell
python -m uvicorn app.main:app --reload
```

Then visit:

- `http://127.0.0.1:8000`
- `http://127.0.0.1:8000/health`

## Required Git Workflow

Use the same workflow throughout the exercise:

```text
Issue → Branch → Change → Commit → Push → Pull Request → CI → Review → Merge
```

Do not perform routine assignment work directly on `main`.

## Week 5 Build Automation

The [CI workflow](.github/workflows/ci.yml) runs on pushes to `main` and pull
requests targeting `main`. It uses `ubuntu-latest`, selects Python 3.13, installs
`requirements.txt`, and runs all 15 tests with `python -m pytest -v`.

After the tests pass, it creates `dist/package` and packages `app/`,
`requirements.txt`, this README, and `VERSION` into `dist/sdi4213-app.zip`.
Python bytecode and cache folders are excluded. `actions/upload-artifact@v4`
uploads the ZIP as **sdi4213-app**, retained for 90 days. A test failure prevents
packaging and upload.

Download **sdi4213-app** from a successful Actions run, then extract the inner
`sdi4213-app.zip`. With GitHub CLI:

```bash
gh run download <RUN_ID> --name sdi4213-app --dir dist/downloaded
unzip -l dist/downloaded/sdi4213-app.zip
unzip dist/downloaded/sdi4213-app.zip -d dist/extracted
```

`VERSION` contains `0.1.0`. The corresponding Git tag is `v0.1.0`; release notes
are recorded in [CHANGELOG.md](CHANGELOG.md) and on the GitHub Release.

## Week 6 Starting Point

The repository contains a starter `Dockerfile` and `.dockerignore` with TODO comments. Complete them using the assignment instructions and course lecture material.

## Evidence

Use `docs/evidence-template.md` to record links, commands, screenshots, and reflections required by the assignment.

## Important

Do not add passwords, API keys, tokens, or other secrets to this repository.
