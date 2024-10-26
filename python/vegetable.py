from flask import Flask, request, jsonify
import pickle
import pandas as pd
from flask_cors import CORS

app = Flask(__name__)
CORS(app, resources={r"/vegepredict": {"origins": "*"}})

# Load the Random Forest model
with open('random_forest_model.pkl', 'rb') as file:
    model = pickle.load(file)

# Load the label encoder
with open('label_encoder1.pkl', 'rb') as file:
    label_encoder = pickle.load(file)
@app.route('/vegepredict', methods=['POST'])
def predict_vegetable():
    try:
        data = request.json
        print("Received data:", data)

        # Create DataFrame from incoming data
        input_data = pd.DataFrame({
            'Temperature(C)': [float(data['Temperature(C)'])],
            'Soil pH': [float(data['Soil pH'])],
            'Humidity': [int(data['Humidity'])],
            'Rainfall': [int(data['Rainfall'])],
        })

        print("Input Data for Prediction:", input_data)

        # Make prediction
        prediction = model.predict(input_data)[0]
        print("Model prediction:", prediction)

        if prediction is None:
            print("Model returned None, cannot make a valid prediction.")
            return jsonify({'error': 'Model returned no valid prediction.'}), 500

        # Validate prediction with the label encoder
        if prediction not in label_encoder.classes_:
            print(f"Prediction {prediction} is not in label encoder classes.")
            return jsonify({'error': f'Invalid prediction: {prediction} is not a known label.'}), 500

        predicted_vegetable = label_encoder.inverse_transform([prediction])
        return jsonify({'prediction': predicted_vegetable[0]})

    except Exception as e:
        print("Error occurred:", e)
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
