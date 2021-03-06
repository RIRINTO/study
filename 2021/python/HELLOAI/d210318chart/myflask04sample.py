from flask import Flask, render_template, request, jsonify

app = Flask(__name__,
            static_url_path='',
            static_folder='static'
            )


@app.route('/')
@app.route('/sample')
def sample():
    return render_template('sample.html')


if __name__ == '__main__':
    app.run(debug=True)
