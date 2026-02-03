from flask import Flask, jsonify

app = Flask(__name__)

@app.get("/")
def home():
    return jsonify({"message": "Hello from Flask on AWS Lambda!"})