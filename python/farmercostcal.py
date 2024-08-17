from flask import Flask, request, jsonify
import pickle
import pandas as pd
from flask_cors import CORS


app = Flask(__name__)
CORS(app)

# Load the machine learning model
with open('model.pkl', 'rb') as file:
    model = pickle.load(file)

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json
    # Extract data from the request
    input_data = pd.DataFrame({
        'Seeds_Price': [data['Seeds_Price']],
        'Fertilizer_Cost': [data['Fertilizer_Cost']],
        'Insecticides_Cost': [data['Insecticides_Cost']],
        'Rained': [data['Rained']],
        'Worker_Cost': [data['Worker_Cost']],
        'USD_Rate': [data['USD_Rate']],
        'Fuel_Price': [data['Fuel_Price']],
        'Month': [data['Month']],
        'Day': [data['Day']],
        'Year': [data['Year']],
    })
    
    # Make a prediction
    prediction = model.predict(input_data)[0]
    
    # Return the prediction as a JSON response
    return jsonify({'prediction': prediction})

if __name__ == '__main__':
    app.run(debug=True)
