import 'package:flutter/material.dart';
import 'package:travel_app/services/api_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> popularDestinations = [];

  @override
  void initState() {
    super.initState();
    fetchPopularDestinations();
  }

  Future<void> fetchPopularDestinations() async {
    try {
      List places = await ApiService.getAllPlace();
      setState(() {
        popularDestinations = places;
      });
    } catch (error) {
      print('Error fetching places: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi Guy!'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search your destination',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryButton('Hotels'),
                _buildCategoryButton('Flights'),
                _buildCategoryButton('All'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Popular Destinations',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            _buildPlaceGrid(), // Hiển thị danh sách địa điểm dạng Grid
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.purple,
      ),
    );
  }

  Widget _buildCategoryButton(String title) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(title),
      style: ElevatedButton.styleFrom(),
    );
  }

  Widget _buildPlaceGrid() {
    return popularDestinations.isEmpty
        ? Center(child: CircularProgressIndicator())
        : GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: popularDestinations.length,
      itemBuilder: (context, index) {
        return _buildPlaceItem(popularDestinations[index]);
      },
    );
  }

  Widget _buildPlaceItem(Map<String, dynamic> place) {
    return Card(
      child: Column(
        children: [
          Image.network(place['imageUrl'], fit: BoxFit.cover), // Lấy ảnh từ JSON
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              place['name'], // Hiển thị tên địa điểm
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Text('Rating: ${place['rating']}'), // Hiển thị đánh giá của địa điểm
        ],
      ),
    );
  }
}
