import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

// Define the Branch model
class Branch {
  final String name;
  final String area;
  final String imagePath;
  final String address;
  final String openingHours;
  // final String contactInfo;
  final List<String> phoneNumbers;
  final String services;
  final String location;
  final double latitude;
  final double longitude;

  Branch({
    required this.name,
    required this.area,
    required this.imagePath,
    required this.address,
    required this.openingHours,
    // required this.contactInfo,
    required this.phoneNumbers,
    required this.services,
    required this.location,
    required this.latitude,
    required this.longitude,
  });
}

final List<Branch> branches = [
  Branch(
    name: 'Head Office',
    area: 'Sharq',
    imagePath: 'assets/images/image copy 3.png',
    address: 'Sharq, Kuwait City',
    openingHours: 'Sun - Thu, 9 AM - 5 PM',
    // contactInfo: 'Phone: +965 2572 1629\nEmail: info@burgan.com',
    phoneNumbers: ["965 2572 1629"],
    services: 'ATM, Customer Service, Account Management',
    /*pick one */ location: 'Sharq, Kuwait City',
    latitude: 29.380829,
    longitude: 47.986074,
  ),
  Branch(
    name: 'Fahad Al Salem Branch',
    area: 'Fahad Al Salem',
    imagePath: 'assets/images/fahad alsalem.jpg',
    address: 'Fahad Al Salem Street, AI-Salhyiah, Essa Al-Saleh sons building',
    openingHours:
        'Sun - Wed\nDay: 9:00 am - 1:00 pm\nEvening: 5:00 pm - 7:00 pm\nThu: 9:00 am - 1:00 pm',
    phoneNumbers: ["22428451", "22428452", "22428424"],
    services: 'ATM, Loans, Account Opening',
    location: 'Salmiya, Block 10',
    latitude: 29.367740,
    longitude: 47.975557,
  ),
  Branch(
    name: 'Salmiya branch',
    area: 'Salmiya',
    imagePath: 'assets/images/image copy.png',
    address: 'Fahad Al Salem Street, AI-Salhyiah, Essa Al-Saleh sons building',
    openingHours:
        'Sun - Wed\nDay: 9:00 am - 1:00 pm\nEvening: 5:00 pm - 7:00 pm\nThu: 9:00 am - 1:00 pm',
    phoneNumbers: ["22428451", "22428452", "22428424"],
    services: 'ATM, Loans, Account Opening',
    location: 'Salmiya, Block 10',
    latitude: 29.330781,
    longitude: 48.069128,
  ),
  Branch(
    name: 'Shuwaikh Industrial branch',
    area: 'Shuwaikh Industrial Area',
    imagePath: 'assets/images/image.png',
    address: 'Fahad Al Salem Street, AI-Salhyiah, Essa Al-Saleh sons building',
    openingHours:
        'Sun - Wed\nDay: 9:00 am - 1:00 pm\nEvening: 5:00 pm - 7:00 pm\nThu: 9:00 am - 1:00 pm',
    phoneNumbers: ["22428451", "22428452", "22428424"],
    services: 'ATM, Loans, Account Opening',
    location: 'Salmiya, Block 10',
    latitude: 29.340568,
    longitude: 47.928145,
  ),
  Branch(
    name: 'Fahaheel branch',
    area: 'Fahaheel',
    imagePath: 'assets/images/image copy 2.png',
    address: 'Fahad Al Salem Street, AI-Salhyiah, Essa Al-Saleh sons building',
    openingHours:
        'Sun - Wed\nDay: 9:00 am - 1:00 pm\nEvening: 5:00 pm - 7:00 pm\nThu: 9:00 am - 1:00 pm',
    phoneNumbers: ["22428451", "22428452", "22428424"],
    services: 'ATM, Loans, Account Opening',
    location: 'Salmiya, Block 10',
    latitude: 29.078436,
    longitude: 48.130154,
  ),
  Branch(
    name: 'AI Jahra Branch',
    area: 'AI Jahra',
    imagePath: 'assets/images/download.png',
    address: 'Fahad Al Salem Street, AI-Salhyiah, Essa Al-Saleh sons building',
    openingHours:
        'Sun - Wed\nDay: 9:00 am - 1:00 pm\nEvening: 5:00 pm - 7:00 pm\nThu: 9:00 am - 1:00 pm',
    phoneNumbers: ["22428451", "22428452", "22428424"],
    services: 'ATM, Loans, Account Opening',
    location: 'Salmiya, Block 10',
    latitude: 29.346000,
    longitude: 47.675537,
  ),
  Branch(
    name: 'Khairan Branch',
    area: 'Sabah Al-Ahmad Sea City',
    imagePath: 'assets/images/download.png',
    address: 'Fahad Al Salem Street, AI-Salhyiah, Essa Al-Saleh sons building',
    openingHours:
        'Sun - Wed\nDay: 9:00 am - 1:00 pm\nEvening: 5:00 pm - 7:00 pm\nThu: 9:00 am - 1:00 pm',
    phoneNumbers: ["22428451", "22428452", "22428424"],
    services: 'ATM, Loans, Account Opening',
    location: 'Salmiya, Block 10',
    latitude: 28.629975,
    longitude: 48.351920,
  ),
  Branch(
    name: 'Marina Mall branch',
    area: 'Salmiya',
    imagePath: 'assets/images/image copy 4.png',
    address: 'Fahad Al Salem Street, AI-Salhyiah, Essa Al-Saleh sons building',
    openingHours:
        'Sun - Wed\nDay: 9:00 am - 1:00 pm\nEvening: 5:00 pm - 7:00 pm\nThu: 9:00 am - 1:00 pm',
    phoneNumbers: ["22428451", "22428452", "22428424"],
    services: 'ATM, Loans, Account Opening',
    location: 'Salmiya, Block 10',
    latitude: 29.342820,
    longitude: 48.067273,
  ),

  // Add more branches as needed
];

// Main app entry point
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      title: 'Burgan Bank',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 10, 95, 164),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 10, 95, 164),
        ),
      ),
    );
  }
}

// Configure go_router for navigation
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/list',
      builder: (context, state) => const ListScreen(),
    ),
    GoRoute(
      path: '/branchDetail',
      builder: (context, state) {
        final branch = state.extra as Branch;
        return BranchDetailPage(branch: branch);
      },
    ),
  ],
);

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Branch> sortedBranches = branches;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Burgan Bank Branches'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _sortBranches,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: sortedBranches.length,
          itemBuilder: (context, index) {
            final branch = sortedBranches[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ListTile(
                contentPadding: const EdgeInsets.all(15),
                leading: ClipOval(
                  child: Image.asset(
                    branch.imagePath,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  branch.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(branch.area),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  context.push('/branchDetail', extra: branch);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _sortBranches() async {
    try {
      final userPosition = await _getUserLocation();
      print(
          "User's Current Location: Latitude = ${userPosition.latitude}, Longitude = ${userPosition.longitude}");

      final sortedList = await _sortBranchesByDistance(userPosition);
      setState(() {
        sortedBranches = sortedList;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Position> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<List<Branch>> _sortBranchesByDistance(Position userPosition) async {
    List<Branch> sortedBranches = List.from(branches);

    sortedBranches.sort((a, b) {
      final distanceA = Geolocator.distanceBetween(userPosition.latitude,
          userPosition.longitude, a.latitude, a.longitude);
      final distanceB = Geolocator.distanceBetween(userPosition.latitude,
          userPosition.longitude, b.latitude, b.longitude);
      return distanceA.compareTo(distanceB);
    });

    return sortedBranches;
  }
}

class BranchDetailPage extends StatelessWidget {
  final Branch branch;

  const BranchDetailPage({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(branch.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  branch.imagePath,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              Text("Contact Info",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              for (var phone in branch.phoneNumbers)
                InkWell(
                  onTap: () => _launchPhone(phone),
                  child: Text(
                    phone,
                    style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                ),

              // buildSection('Contact Info', branch.contactInfo,
              //     isPhoneNumber: true),
              buildSection('Services Offered', branch.services),
              buildSection('Opening Hours', branch.openingHours),
              buildSection('Location', branch.address),
              const SizedBox(height: 20),

              // Clickable Image for Google Maps
              InkWell(
                onTap: () => _launchMaps(branch.latitude, branch.longitude),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/headloc.png',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Click on the map to open in Google Maps',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection(String title, String content,
      {bool isPhoneNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          isPhoneNumber
              ? InkWell(
                  onTap: () => _launchPhone(content),
                  child: Text(
                    content,
                    style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                )
              : Text(content),
        ],
      ),
    );
  }

  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri.parse("tel:$phone");

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch phone call to $phone';
    }
  }

  Future<void> _launchMaps(double latitude, double longitude) async {
    final Uri googleMapsUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${latitude.toString()},${longitude.toString()}');

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      throw 'Could not launch Google Maps';
    }
  }
}

var numbers = <int>[1, 2, 3, for (int i = 0; i < 10; i++) (i + 50) * 10];
