from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.get("/")
def index():
    name = os.getenv("APP_NAME", "hello-from-aks")
    return jsonify(message=f"Hi from {name}!"), 200

@app.get("/healthz")
def health():
    return "ok", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.getenv("PORT", "8080")))
