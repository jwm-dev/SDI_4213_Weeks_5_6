# Week 5–6 Exercise Evidence

Name: jwm-dev (authenticated GitHub account)

GitHub repository: https://github.com/jwm-dev/SDI_4213_Weeks_5_6

Course: SDI 4213-980 – DevOps: CI/CD

Completed: October 1, 2026 (America/Chicago)

## Part A – Starting validation

- Created the GitHub repository from the supplied starter, preserving the app,
  pinned requirements, and all tests. Cloned it locally and opened the workspace
  in VS Code.
- Recreated `.venv` with Python 3.13.15, installed `requirements.txt`, and ran
  `python -m pip check`: **No broken requirements found**.
- Local `python -m pytest -v`: **15 passed**, before assignment changes.
  [Captured baseline output](evidence/baseline-pytest.txt).
- Initial CI: **success**, [baseline workflow run](https://github.com/jwm-dev/SDI_4213_Weeks_5_6/actions/runs/36925881257).
- Existing workflow: pull requests targeting `main` and pushes to `main`;
  `ubuntu-latest` runner; `actions/setup-python@v5` with Python 3.13 and pip
  caching; dependency installation with `python -m pip`; tests with
  `python -m pytest -v`.
- The local application returned `{"status":"ok"}` from `/health`.

## Part B – Week 5 build automation

- Issue: [Add automated build artifact #1](https://github.com/jwm-dev/SDI_4213_Weeks_5_6/issues/1).
- Branch: `feature/build-artifact`, created from the starter `main`.
- Pull request: [Add automated build artifact #2](https://github.com/jwm-dev/SDI_4213_Weeks_5_6/pull/2), reviewed and merged after passing CI.
- Successful workflow: [build PR run](https://github.com/jwm-dev/SDI_4213_Weeks_5_6/actions/runs/36926050064).
- Artifact name: **sdi4213-app**, uploaded with `actions/upload-artifact@v4`
  after pytest passes. Retention: 90 days.
- ZIP: `dist/sdi4213-app.zip`; source files assembled in `dist/package`.
- Downloaded the real workflow artifact and extracted it:

  ```bash
  gh run download 36926050064 --name sdi4213-app --dir dist/downloaded
  unzip dist/downloaded/sdi4213-app.zip -d dist/extracted
  ```

- The ZIP passed its integrity check, every file matched the reviewed source
  byte-for-byte, and its `VERSION` contained `0.1.0`.
  [Artifact verification output](evidence/artifact-contents.txt).
- The extracted artifact was also started with Uvicorn and returned
  `{"status":"ok"}` from `/health`.
  [Extracted artifact output](evidence/extracted-artifact-health.txt).
- Downloaded ZIP contents:

  ```text
  README.md
  VERSION
  app/__init__.py
  app/main.py
  app/models.py
  app/services.py
  requirements.txt
  ```

No `.venv`, credentials, Python bytecode, or caches are included in the package.

## Part C – Version and release

- `VERSION`: **0.1.0**.
- Annotated Git tag: [v0.1.0](https://github.com/jwm-dev/SDI_4213_Weeks_5_6/tree/v0.1.0).
- Tag points to build PR merge commit `3ce31ba`, created after updating local
  `main` with `git pull --ff-only`.
- [GitHub Release](https://github.com/jwm-dev/SDI_4213_Weeks_5_6/releases/tag/v0.1.0):
  **Version 0.1.0 - Build and Containerization Exercise**.
- Release notes describe the inventory application, its 15 automated tests,
  and the test-gated CI ZIP build. `CHANGELOG.md` records the release.
- The verified workflow ZIP is attached as a permanent
  [release asset](https://github.com/jwm-dev/SDI_4213_Weeks_5_6/releases/download/v0.1.0/sdi4213-app.zip).
- SHA-256: `3bda490ca73b16a8e175398f323b83113d42a1a67dd8341bf83131a9a6fd1300`.
- Following Parts 4–7 of the assignment, this tag precedes the Docker PR.
  Container configuration is subsequently merged into `main`; the application
  source and `VERSION` stay unchanged, so the image uses version `0.1.0`.

## Part D – Week 6 Docker

- Issue: [Containerize application #3](https://github.com/jwm-dev/SDI_4213_Weeks_5_6/issues/3).
- Branch: `feature/docker-container`, created from updated `main` after the
  build PR merge and `v0.1.0` release.
- Pull request: [Containerize application with Docker #4](https://github.com/jwm-dev/SDI_4213_Weeks_5_6/pull/4).
- Workflow run: [Docker PR CI](https://github.com/jwm-dev/SDI_4213_Weeks_5_6/actions/runs/36926764886).
  The [PR checks](https://github.com/jwm-dev/SDI_4213_Weeks_5_6/pull/4/checks)
  also show CI for the final documentation commit.
- Runtime: **Docker Desktop 4.48.0**, Docker Engine **28.5.1**, context
  `desktop-linux`, on this Intel Mac running macOS 13.7.8.
  [Captured Docker version](evidence/docker-version.txt).
- Dockerfile: `python:3.13-slim`, work directory `/app`, requirements copied and
  installed before app source, no pip cache, port 8000 exposed, and Uvicorn bound
  to `0.0.0.0:8000`.
- `.dockerignore` excludes `.git`, `.github`, `.venv`, `__pycache__`,
  `.pytest_cache`, `*.pyc`, `.env`, and `dist`, plus other development files.
- Build: `docker build --progress=plain -t sdi4213-week56:0.1.0 .` succeeded.
  [Complete build output](evidence/docker-build.txt).
- Image: **sdi4213-week56:0.1.0**, **251 MB**, ID **01eb05ba1346**.
- Full image ID:
  `sha256:01eb05ba1346b7a6fe944580689ef5ed7483f9e9be4e58c4bff6f20135e50f56`.
- Start: `docker run -d -p 8000:8000 --name sdi4213-week56-demo sdi4213-week56:0.1.0`.
- Running container: **e2ec8054eb33**, with host port 8000 published to container
  port 8000. Image/container listing commands filter this exercise's resources.
- `curl --silent --show-error --fail http://localhost:8000/health` returned
  **HTTP 200** and **`{"status":"ok"}`**.
- Container logs showed application startup, Uvicorn listening on
  `http://0.0.0.0:8000`, and `GET /health HTTP/1.1` with **200 OK**.
- Container Python: **3.13.15**; `python -m pip check` reported
  **No broken requirements found**.
- Cleanup: `docker stop sdi4213-week56-demo`, then
  `docker rm sdi4213-week56-demo`. `docker ps -a` confirmed the demo was gone.
  `docker images sdi4213-week56` and image inspection confirmed the same image
  still existed with the same full ID.
- [Captured images, running container, health, logs, stop/remove, and retained image](evidence/docker-lifecycle.txt).
- [Recorded image configuration and verification results](evidence/docker-image.json).
- Final local pytest: **15 passed**.
  [Captured output](evidence/final-pytest.txt).

## Reflection

1. **What is the difference between a workflow artifact and a Docker image?**
   The workflow artifact here is a retained ZIP containing application source,
   requirements, README, and version metadata. Running it requires an available
   Python environment and installed dependencies. A Docker image packages the
   application with a Python runtime, installed dependencies, filesystem layers,
   and startup command. Docker creates containers from that image. The ZIP
   does not include an operating-system environment or a running process.

2. **Why did you tag the Git release and Docker image with a version?**
   `v0.1.0` identifies the released source commit, while
   `sdi4213-week56:0.1.0` identifies the corresponding application image version.
   Shared version numbers help connect source, build, and runtime during testing,
   troubleshooting, and rollback. Git tags and Docker tags can be moved, so they
   should be treated as fixed release labels; recording commit IDs, image IDs,
   and digests provides stronger identification.

3. **What does `-p 8000:8000` do?**
   It publishes host TCP port 8000 to port 8000 inside the container. A request
   to `http://localhost:8000/health` reaches Uvicorn in the container, which binds
   to `0.0.0.0:8000`. The first number is the host port; the second is the
   container port. `EXPOSE 8000` documents the port but does not publish it.

4. **What would you automate next if this project were moving toward deployment?**
   After the existing tests, build the Docker image in CI, scan it, test a running
   container's `/health`, and publish it to a registry with a version tag and
   recorded digest. Deploy that digest to staging, verify health, then promote
   the same image to production with an approval and rollback process. Use
   managed secrets for deployment credentials and external configuration;
   replace the application's in-memory inventory with persistent storage before
   relying on it across restarts or multiple replicas.

## Review record

This individual exercise used documented self-reviews on the authenticated
account before merging. GitHub prevents PR authors from approving their own
PRs; the reviews are recorded as comments, not independent approvals.
