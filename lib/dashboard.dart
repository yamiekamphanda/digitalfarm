import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? _selectedLocation = 'Blantyre'; // Default location

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon tap
            },
          ),
        ],
        title: Expanded(
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration.collapsed(
              hintText: '',
            ),
            value: _selectedLocation,
            onChanged: (String? value) {
              if (value != null) {
                setState(() {
                  _selectedLocation = value;
                });
              }
            },
            items: ['Lilongwe', 'Blantyre', 'Mzuzu']
                .map((location) => DropdownMenuItem(
                      value: location,
                      child: Text(location),
                    ))
                .toList(),
          ),
        ),
        centerTitle: true, // Center the title in the app bar
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Profile'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                // Navigate to Home page
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                // Navigate to Profile page
              },
            ),
            ListTile(
              title: const Text('NearBySection'),
              onTap: () {
                // Navigate to NearBySection
              },
            ),
            ListTile(
              title: const Text('BookmarksSection'),
              onTap: () {
                // Navigate to BookmarksSection
              },
            ),
            ListTile(
              title: const Text('NotificationSection'),
              onTap: () {
                // Navigate to NotificationSection
              },
            ),
            ListTile(
              title: const Text('MessageSection'),
              onTap: () {
                // Navigate to MessageSection
              },
            ),
            ListTile(
              title: const Text('RecommendForYouSection'),
              onTap: () {
                // Navigate to RecommendForYouSection
              },
            ),
            ListTile(
              title: const Text('SettingsSection'),
              onTap: () {
                // Navigate to SettingsSection
              },
            ),
            ListTile(
              title: const Text('AddHouseButton'),
              onTap: () {
                // Perform action for AddHouseButton
              },
            ),
            ListTile(
              title: const Text('LogoutButton'),
              onTap: () {
                // Perform action for LogoutButton
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xFFF2F2F2),
                      ),
                      child: const Row(
                        children: [
                          // Add a leading icon for search
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 8.0,
                                0.0), // Adjust padding as needed
                            child: Icon(Icons.search),
                          ),
                          Expanded(
                            // Ensures the text field takes remaining space
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter address',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                    height: 40.0,
                    width: 80.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xFF007AFF),
                    ),
                    child: TextButton(
                      onPressed: () => print('Filter tapped'),
                      child: const Text(
                        'Filter',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => print('Apartment tapped'),
                      child: const Text(
                        'Apartment',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    TextButton(
                      onPressed: () => print('House tapped'),
                      child: const Text(
                        'House',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    TextButton(
                      onPressed: () => print('Hotel tapped'),
                      child: const Text(
                        'Hotel',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    TextButton(
                      onPressed: () => print('Villa tapped'),
                      child: const Text(
                        'Villa',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    TextButton(
                      onPressed: () => print('Office Building tapped'),
                      child: const Text(
                        'Office Building',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Near you'),
                  TextButton(
                    onPressed: () => print('View All tapped'),
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              // Container 2: Image scrollable list
              Container(
                height: 200.0, // Adjust height as needed
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildPropertyCard(
                      'assets/images/swimming-pool-house.jpg',
                      'Swimming Pool House',
                    ),
                    _buildPropertyCard(
                      'assets/images/garden-house.jpg',
                      'Garden House',
                    ),
                    _buildPropertyCard(
                      'assets/images/hotel-room.jpg',
                      'Hotel Room',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Recommende for you'),
                  TextButton(
                    onPressed: () => print('View All tapped'),
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Container(
                height: 400.0, // Adjust height as needed
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 4, // Replace with actual data count
                  itemBuilder: (context, index) {
                    return _buildPropertyRow(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyCard(String imagePath, String propertyName) {
    return Container(
      width: 200.0, // Set the same width for all cards
      margin: const EdgeInsets.only(right: 10.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 120.0,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    propertyName,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Area 30',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                  const Text(
                    '2.5 Kms',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Text('4.8'),
                    ],
                  ),
                  Icon(Icons.favorite_border, color: Colors.grey),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyRow(int index) {
    List<String> imagePaths = [
      'assets/images/dinning-house.jpg',
      'assets/images/sitting-house.jpg',
    ];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Image column
          Container(
            width: 120.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imagePaths[index % imagePaths.length],
                fit: BoxFit.cover,
                height: 120.0,
                width: double.infinity,
              ),
            ),
          ),
          // Details column
          Container(
            width: 200.0,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getBedroomHouseName(index),
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                const Text(
                  'Area 45',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5.0),
                const Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.king_bed, size: 16.0),
                        SizedBox(width: 5.0),
                        Text('3'), // Guessed number of bedrooms
                      ],
                    ),
                    SizedBox(width: 20.0),
                    Row(
                      children: [
                        Icon(Icons.bathtub, size: 16.0),
                        SizedBox(width: 5.0),
                        Text('2'), // Guessed number of bathrooms
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getBedroomHouseName(int index) {
    List<String> names = [
      'Dining Room House',
      'Sitting Room House',
    ];
    return names[index % names.length];
  }
}

void main() {
  runApp(const MaterialApp(
    home: DashboardPage(),
  ));
}
