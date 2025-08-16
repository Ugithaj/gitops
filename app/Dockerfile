# Build
FROM python:3.12-slim AS build
WORKDIR /src
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Runtime
FROM python:3.12-slim
ENV PORT=8080
WORKDIR /app
COPY --from=build /usr/local /usr/local
COPY . .
EXPOSE 8080
CMD ["gunicorn", "-b", "0.0.0.0:8080", "main:app"]
