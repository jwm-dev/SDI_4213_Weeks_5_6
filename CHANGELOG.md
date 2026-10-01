# Changelog

## Unreleased

### Added
- Dockerfile using Python 3.13 slim and Uvicorn on port 8000.
- Docker build-context exclusions for development files, caches, and environment files.
- Container build/run/health/log/cleanup evidence for image `sdi4213-week56:0.1.0`.

The Docker configuration follows the Week 5 `v0.1.0` release, as required by the
assignment sequence. The application source and `VERSION` remain unchanged.

## [0.1.0] - 2026-10-01

### Added
- FastAPI inventory application and its 15 automated tests from the starter.
- A CI ZIP package containing `app/`, `requirements.txt`, `README.md`, and `VERSION`.
- GitHub Actions artifact upload after the existing automated tests pass.
- Python 3.13 version selection and macOS setup instructions.

[0.1.0]: https://github.com/jwm-dev/SDI_4213_Weeks_5_6/releases/tag/v0.1.0
