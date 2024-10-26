from flask import Flask, request, jsonify
import pickle
import pandas as pd
from flask_cors import CORS

app = Flask(__name__)
CORS(app, resources={r"/vegepredict": {"origins": "*"}})

# Load the Random Forest model
with open('random_forest_model.pkl', 'rb') as file:
    model = pickle.load(file)

# Custom vegetable labeling function
def label_vegetable(data):
    pH = data['Soil pH']
    temp = data['Temperature(C)']
    rainfall = data['Rainfall']
    humidity = data['Humidity']

    # Vegetable labeling logic
    if 6.0 <= pH <= 6.8 and 15 <= temp <= 21 and rainfall == 1 and 50 < humidity <= 70:
        return 'Carrot'
    elif 5.5 <= pH <= 6.8 and 21 <= temp <= 29 and rainfall == 1 and humidity > 70:
        return 'Eggplant'
    elif 6.0 <= pH <= 7.5 and 15 <= temp <= 21 and rainfall == 1 and 50 <= humidity <= 70:
        return 'Cabbage'
    elif 4.8 <= pH <= 6.5 and 15 <= temp <= 21 and rainfall == 1 and 50 <= humidity <= 70:
        return 'Potato'
    elif 6.0 <= pH <= 7.0 and 21 <= temp <= 29 and rainfall == 1 and humidity > 70:
        return 'Capsicum'
    else:
        return None

@app.route('/vegepredict', methods=['POST'])
def predict_vegetable():
    try:
        data = request.json
        print("Received data:", data)

        # Convert input data to the required format for model
        input_data = pd.DataFrame({
            'Temperature(C)': [float(data['Temperature(C)'])],
            'Soil pH': [float(data['Soil pH'])],
            'Humidity': [int(data['Humidity'])],
            'Rainfall': [int(data['Rainfall'])],
        })

        print("Input Data for Prediction:", input_data)

        # Attempt model prediction
        try:
            model_prediction = model.predict(input_data)[0]
            print("Model prediction:", model_prediction)
        except Exception as e:
            print("Model prediction error:", e)
            model_prediction = None

        # Fall back to rule-based prediction if model prediction is None
        if model_prediction:
            return jsonify({'prediction': model_prediction})
        else:
            rule_based_prediction = label_vegetable({
                'Temperature(C)': float(data['Temperature(C)']),
                'Soil pH': float(data['Soil pH']),
                'Humidity': int(data['Humidity']),
                'Rainfall': int(data['Rainfall'])
            })
            
            if rule_based_prediction:
                return jsonify({'prediction': rule_based_prediction})
            else:
                return jsonify({'error': 'No suitable prediction found.'}), 500

    except Exception as e:
        print("Error occurred:", e)
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
