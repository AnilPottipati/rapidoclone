import 'package:flutter/material.dart';
import 'package:rapidoclone/models/location.dart';
import 'package:rapidoclone/widgets/location_card.dart';
import 'package:rapidoclone/widgets/service_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Sample data - replace with actual data fetching later
  final List<Location> _recentLocations = [
    Location(
      id: '1',
      name: 'Office',
      address: '123 Business Street, City Center',
      timestamp: DateTime.now(),
    ),
    Location(
      id: '2',
      name: 'Home',
      address: '456 Residential Lane',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  final List<Map<String, dynamic>> _services = [
    {'title': 'Bike', 'icon': Icons.motorcycle, 'color': Colors.orange},
    {'title': 'Auto', 'icon': Icons.car_rental, 'color': Colors.blue},
  ];

  final List<Map<String, dynamic>> _goPlaces = [
    {'image': 'assets/images/place1.jpg', 'title': 'City Center'},
    {'image': 'assets/images/place2.jpg', 'title': 'Business District'},
    {'image': 'assets/images/place3.jpg', 'title': 'Airport'},
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Search
          SliverAppBar(
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 0,
            titleSpacing: 0,
            title: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.menu_rounded, color: Colors.black),
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(60), // Set to 60px
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Where are you going?',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            60,
                          ), // Match here too
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200], // Optional background
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Recent Locations
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Recent Locations',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _recentLocations.length,
                  itemBuilder: (context, index) {
                    final location = _recentLocations[index];
                    return LocationCard(
                      location: location,
                      onTap: () {},
                      onFavoriteTap: () {},
                    );
                  },
                ),
              ],
            ),
          ),

          // Explore Services
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Explore Services',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        _services.map((service) {
                          return Expanded(
                            child: ServiceCard(
                              title: service['title'],
                              icon: service['icon'],
                              color: service['color'],
                              onTap: () {},
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Ad Container
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text('Ad Placeholder')),
            ),
          ),

          // Go Places
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Go Places with Rapido',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _goPlaces.length,
                    itemBuilder: (context, index) {
                      final place = _goPlaces[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(place['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          place['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: _goPlaces.length,
                    effect: const WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Another Ad Container
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text('Ad Placeholder')),
            ),
          ),

          // Background Image
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
