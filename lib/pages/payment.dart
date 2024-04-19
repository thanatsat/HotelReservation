import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/pages/root_app.dart';

class PaymentSettings extends StatefulWidget {
  @override
  _PaymentSettingsState createState() => _PaymentSettingsState();
}

class _PaymentSettingsState extends State<PaymentSettings> {
  int selectedIndex = -1;

  // Text editing controllers for the text fields
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController licensePlateController = TextEditingController();

  bool _isContactNumberValid = true;
  bool _isLicensePlateValid = true;

  Future<void> saveBookingData(BuildContext context) async {
    // Check each field for emptiness or invalidity
    if (selectedIndex == -1 ||
        !_isContactNumberValid ||
        !_isLicensePlateValid ||
        firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        nicknameController.text.isEmpty) {
      // Show error message if any field is empty, invalid, or if payment method is not selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(selectedIndex == -1
                ? 'Please select a payment method'
                : 'Please fill out all fields correctly'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      // Save booking data to Firestore
      await FirebaseFirestore.instance.collection('booking').add({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'nickname': nicknameController.text,
        'contactNumber': contactNumberController.text,
        'licensePlate': licensePlateController.text,
        'paymentMethod': selectedIndex == 0
            ? 'Pay on check in day'
            : 'Pay now by online banking',
        'timestamp': DateTime.now(),
      });
      // Navigate to the booking page after saving the data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RootApp(),
        ),
      );
    } catch (error) {
      print('Error saving booking data: $error');
      // Handle error here
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to save booking data. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Payment',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              height: 0.06,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              // Circular avatar for the image
              SizedBox(
                height: 160,
                width: 350,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Choose your payment method',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            buildBulletItem(0, 'Pay on check in day'),
                            buildBulletItem(1, 'Pay now by online banking'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Payment details form
              SizedBox(
                height: 450,
                width: 350,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your Payment Details',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Text fields for payment details
                        TextField(
                          controller: firstNameController,
                          decoration: InputDecoration(labelText: 'First Name'),
                        ),
                        TextField(
                          controller: lastNameController,
                          decoration: InputDecoration(labelText: 'Last Name'),
                        ),
                        TextField(
                          controller: nicknameController,
                          decoration: InputDecoration(labelText: 'Nickname'),
                        ),
                        TextField(
                          controller: contactNumberController,
                          decoration: InputDecoration(
                            labelText: 'Contact Number',
                            errorText: _isContactNumberValid
                                ? null
                                : 'Invalid contact number',
                          ),
                          onChanged: (_) {
                            setState(() {
                              _isContactNumberValid = _validateContactNumber(
                                  contactNumberController.text);
                            });
                          },
                        ),
                        TextField(
                          controller: licensePlateController,
                          decoration: InputDecoration(
                            labelText: 'License Plate',
                            errorText: _isLicensePlateValid
                                ? null
                                : 'Invalid license plate',
                          ),
                          onChanged: (_) {
                            setState(() {
                              _isLicensePlateValid = _validateLicensePlate(
                                  licensePlateController.text);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => saveBookingData(context),
                icon: Icon(Icons.hotel_class),
                label: Text(
                  'Book',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBulletItem(int index, String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            selectedIndex == index
                ? Icon(Icons.check_circle)
                : Icon(Icons.radio_button_unchecked),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateContactNumber(String value) {
    // Validate contact number (e.g., must not be empty and only contain numeric characters)
    return value.isNotEmpty && int.tryParse(value) != null;
  }

  bool _validateLicensePlate(String value) {
    // Validate license plate (e.g., must not be empty and only contain numeric characters)
    return value.isNotEmpty && int.tryParse(value) != null;
  }
}
