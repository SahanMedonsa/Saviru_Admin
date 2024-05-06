import 'package:flutter/material.dart';

class chooseBestfertilzer extends StatefulWidget {
  const chooseBestfertilzer({super.key});

  @override
  State<chooseBestfertilzer> createState() => _chooseBestfertilzerState();
}

String selectedSoilType = 'Loam'; // Default soil type
String selectedCropType = 'Tomato'; // Default crop type
String selectedHistoricalYield = 'High'; // Default historical yield
String selectedClimateType = 'Temperate'; // Default climate type

List<String> soilTypes = ['Loam', 'Clay', 'Sandy', 'Silt'];
List<String> cropTypes = ['Tomato', 'Lettuce', 'Carrot', 'Potato'];
List<String> historicalYields = ['Low', 'Medium', 'High'];
List<String> climateTypes = ['Temperate', 'Tropical', 'Subtropical'];

String recommendedFertilizer = ''; // Placeholder for recommended fertilizer

void generateRecommendation() {
  // Simulate fertilizer recommendation based on selected parameters
  (() {
    // Implement your recommendation logic here based on selected dropdown values
    recommendedFertilizer = 'NPK 20-10-10'; // Example recommendation
  });
}

class _chooseBestfertilzerState extends State<chooseBestfertilzer> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<String>(
            value: selectedSoilType,
            items: soilTypes.map((soilType) {
              return DropdownMenuItem<String>(
                value: soilType,
                child: Text(soilType),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedSoilType = value!;
              });
            },
            decoration: InputDecoration(
              labelText: 'Select Soil Type',
            ),
          ),
          DropdownButtonFormField<String>(
            value: selectedCropType,
            items: cropTypes.map((cropType) {
              return DropdownMenuItem<String>(
                value: cropType,
                child: Text(cropType),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCropType = value!;
              });
            },
            decoration: InputDecoration(
              labelText: 'Select Crop Type',
            ),
          ),
          DropdownButtonFormField<String>(
            value: selectedHistoricalYield,
            items: historicalYields.map((yield) {
              return DropdownMenuItem<String>(
                value: yield,
                child: Text(yield),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedHistoricalYield = value!;
              });
            },
            decoration: InputDecoration(
              labelText: 'Select Historical Yield',
            ),
          ),
          DropdownButtonFormField<String>(
            value: selectedClimateType,
            items: climateTypes.map((climateType) {
              return DropdownMenuItem<String>(
                value: climateType,
                child: Text(climateType),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedClimateType = value!;
              });
            },
            decoration: InputDecoration(
              labelText: 'Select Climate Type',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              generateRecommendation();
            },
            child: Text('Generate Recommendation'),
          ),
          SizedBox(height: 20),
          Text(
            'Recommended Fertilizer: $recommendedFertilizer',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
