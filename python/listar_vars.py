from flask import Flask
app = Flask(__name__)
import os

@app.route("/conf/env")
def listar_vars():
      return os.popen('printenv').read()

if __name__ == '__main__':
    app.run(host='localhost', port=8080)


