import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_assessment/screens/nftsListDetails.dart';
import 'package:http/http.dart' as http;

class NftsListScreen extends StatefulWidget {
  @override
  _NftsListScreenState createState() => _NftsListScreenState();
}

class _NftsListScreenState extends State<NftsListScreen> {
  List<Map<String, dynamic>> Nfts = [];
  bool isLoading = true; // Track the loading state

  final url = Uri.https("api.coingecko.com", "/api/v3/nfts/list");

  void loadNft() async {
    var response = await http.get(url);
    setState(() {
      Nfts = List<Map<String, dynamic>>.from(json.decode(response.body));
      isLoading = false; // Update loading state when data is fetched
    });
  }

  @override
  void initState() {
    super.initState();
    loadNft();
  }

  void handleNftDetails(String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => nftsListDetails(id: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NFTs List'),
      ),
      body: isLoading // Check the loading state
          ? Center(
              child: CircularProgressIndicator(), // Show loading indicator
            )
          : ListView.builder(
              itemCount: Nfts.length,
              itemBuilder: (context, index) {
                final nft = Nfts[index];
                return InkWell(
                  onTap: () {
                    handleNftDetails(nft['id']);
                  },
                  child: Card(
                    elevation: 2,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: nft['imageUrl'] != null
                            ? NetworkImage(nft['imageUrl'])
                            : null,
                      ),
                      title: Text(
                        nft['name'] ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        nft['description'] ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
