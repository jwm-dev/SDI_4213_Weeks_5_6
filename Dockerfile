# WEEK 6 STARTER DOCKERFILE
# Complete each TODO using the Week 6 lecture and assignment instructions.

# TODO 1: Choose the Python 3.13 slim base image.
FROM python:3.13-slim

# TODO 2: Set the working directory inside the image.
WORKDIR /app

# TODO 3: Copy requirements.txt before copying the application source.
COPY requirements.txt .

# TODO 4: Install Python dependencies without retaining the pip cache.
# RUN ...

# TODO 5: Copy the app directory into the image.
# COPY ...

# TODO 6: Document the FastAPI application port.
# EXPOSE ...

# TODO 7: Start Uvicorn and bind to 0.0.0.0 on port 8000.
# CMD [...]
