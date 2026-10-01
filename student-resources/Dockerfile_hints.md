# Dockerfile Hints

Create a file named `Dockerfile` in the repository root.

Your Dockerfile will need instructions that accomplish these tasks:

1. Start from a Python 3.13 slim base image.
2. Set `/app` as the working directory.
3. Copy `requirements.txt` first.
4. Install the Python dependencies.
5. Copy the `app` directory into the image.
6. Document that the application uses port 8000.
7. Start Uvicorn so it listens on `0.0.0.0:8000`.

Useful Dockerfile instructions to research:

- `FROM`
- `WORKDIR`
- `COPY`
- `RUN`
- `EXPOSE`
- `CMD`

Also create a `.dockerignore` file so that items such as `.git`, `.venv`, `__pycache__`, `.pytest_cache`, and `.env` are not sent into the Docker build context.
