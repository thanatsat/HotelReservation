import 'package:flutter/material.dart';
import 'package:test/pages/payment.dart';

class FeatureDetailsPage extends StatefulWidget {
  final Map feature;

  const FeatureDetailsPage({Key? key, required this.feature}) : super(key: key);

  @override
  _FeatureDetailsPageState createState() => _FeatureDetailsPageState();
}

class _FeatureDetailsPageState extends State<FeatureDetailsPage> {
  late String selectedLocation;
  late List<String> locations;

  @override
  void initState() {
    super.initState();
    locations = [];
    // Check if widget.feature['location'] is a List<String>
    if (widget.feature['location'] is List<String>) {
      locations = widget.feature['location'] as List<String>;
    } else if (widget.feature['location'] is String) {
      // If it's a single string, add it to the locations list
      locations.add(widget.feature['location'] as String);
    }
    // Set initial dropdown value
    selectedLocation = locations.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.feature["name"]}',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.feature["image"]),
                    fit: BoxFit.contain, // Change to BoxFit.contain
                  ),
                ),
              ),
              SizedBox(
                height: 550,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.hotel), // Icon for Type
                              SizedBox(width: 5),
                              Text(
                                'Type: ${widget.feature["type"]}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.attach_money), // Icon for Price
                              SizedBox(width: 5),
                              Text(
                                'Price: ${widget.feature["price"]}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(width: 5),
                              Text(
                                'Location: $selectedLocation',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.description),
                              SizedBox(width: 5),
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 8.0),
                          child: Text(
                            '${widget.feature["description"]}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentSettings(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.book),
                              label: Text(
                                'Book Now',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: DropdownButton<String>(
                                value: selectedLocation,
                                onChanged: (String? newValue) {
                                  // Update selected location
                                  if (newValue != null) {
                                    setState(() {
                                      selectedLocation = newValue;
                                    });
                                  }
                                },
                                items: locations.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Center(
                                        child: Text(
                                            value), // Align text in the middle
                                      ),
                                    );
                                  },
                                ).toList(),
                                // Center alignment of dropdown items
                                alignment: Alignment.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
