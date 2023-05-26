import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class nftsListDetails extends StatefulWidget {
  const nftsListDetails({super.key, required this.id});
  final String id;
  @override
  _nftsListDetailsState createState() => _nftsListDetailsState();
}

class _nftsListDetailsState extends State<nftsListDetails> {
  final _formKey = GlobalKey<FormState>();
  var _userName = '';
  bool _isButtonEnabled = false; // Add this line

  var nftDetails;

  void loadNft() async {
    final url = Uri.https("api.coingecko.com", "/api/v3/nfts/${widget.id}");
    var response = await http.get(url);
    var decodedResponse = json.decode(response.body);
    setState(() {
      nftDetails = decodedResponse;
    });
  }

  void _checkTextFieldValue() {
    setState(() {
      _isButtonEnabled = _formKey.currentState!.validate();
    });
  }

  @override
  void initState() {
    super.initState();
    loadNft();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFT Details'),
      ),
      body: nftDetails == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.network(nftDetails['image']['small']),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        nftDetails['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        nftDetails['description'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Symbol: ${nftDetails['symbol']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Price: ${nftDetails['floor_price']['native_currency']} ${nftDetails['floor_price']['usd']} USD',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              label: Text(
                                "enter your..",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 220, 208, 208),
                                    fontSize: 22),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 228, 220, 220)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 229, 226, 226)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length <= 1 ||
                                  value.trim().length > 12) {
                                return 'Must be between 1 and 8 characters.';
                              }
                              return null;
                            },
                            maxLength: 10,
                            initialValue: _userName,
                            onChanged: (value) {
                              _checkTextFieldValue(); // Call the method to update the button state
                            },
                            onSaved: (value) {
                              _userName = value!;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: _isButtonEnabled
                                ? () {}
                                : null, // Enable or disable the button
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(8),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 219, 222, 225)),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    horizontal: 60, vertical: 14),
                              ),
                            ),
                            child: const Text(
                              'Button',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
