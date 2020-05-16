from flask import Flask
import os
app = Flask(__name__)

@app.route("/env/<name>/<var>", methods=["POST"])
def criar_varivel(name, var):
    os.environ[name] = var
    return "A Variavel " + os.environ.get(name) + " foi criada com sucesso!"

if __name__ == '__main__':
  app.run(debug=True, port= 8080)
