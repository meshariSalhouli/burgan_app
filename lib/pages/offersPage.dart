import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OffersPage extends StatefulWidget {
  OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  final List<Map<String, String>> offers = [
    {
      "title": "Credit Card Cashbacks",
      "description":
          "Get up to 5% cashback on all purchases with our premier Card.",
      "expiry": "Valid until Dec 31, 2024"
    },
    {
      "title": "Home Loan Discount",
      "description": "Enjoy a reduced interest rate of 2.5% on new home loans.",
      "expiry": "Valid until Jan 31, 2025"
    },
    {
      "title": "Travel Insurance Offer",
      "description": "Free travel insurance with every international transfer.",
      "expiry": "Valid until Feb 28, 2025"
    }
  ];

  final String instagramEmbedUrl =
      'https://www.instagram.com/p/DBquz6RoALA/embed';

  // Loading
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // if (Platform.isIOS) {
    //   WebView.platform = SurfaceWebView();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offers')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Instagram Post Embed
          Text("Our Instagram Post",
              style: Theme.of(context).textTheme.titleLarge),
          SizedBox(
            height: 400,
            child: Stack(
              children: [
                WebView(
                  initialUrl: instagramEmbedUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: (url) {
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  gestureNavigationEnabled: true,
                ),
                if (_isLoading) //Show loading
                  Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
          const SizedBox(height: 20),

          //Offer Cards
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: offers.length,
            itemBuilder: (context, index) {
              final offer = offers[index];
              return OfferCard(offer: offer);
            },
          ),
        ],
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  final Map<String, String> offer;

  const OfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              offer["title"]!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(offer["description"]!),
            const SizedBox(height: 8.0),
            Text(
              "Expiry: ${offer["expiry"]!}",
              style: const TextStyle(color: Colors.redAccent),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                // Implement your "Learn More" functionality here
              },
              child: const Text("Learn More"),
            ),
          ],
        ),
      ),
    );
  }
}
