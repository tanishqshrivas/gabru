import 'package:flutter/material.dart';
import 'home_page2.dart'; // QuickAccessSection
import 'home_page3.dart'; // TodaysMedicationsSection

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F8E0),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16,right: 16,bottom: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification section
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: _buildNotificationCard(),
            ),


            // Today's Medications section - now using extracted component
            const TodaysMedicationsSection(),

            const SizedBox(height: 20),

            // Quick Access section - using extracted component
            const QuickAccessSection(),
          ],
        ),
      ),
    );
  }


  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFFDEF1D8),
      elevation: 0,
      titleSpacing: 0,
      title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => _handleMenuPressed(),
          ),
          _buildAppBarLogo(),
          const SizedBox(width: 6),
          const Text(
            'Sanjeevika',
            style: TextStyle(
              color: Color(0xFF16833D),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Spacer(), // 👈 Adds flexible space between title and user profile
        ],
      ),
      actions: [
        _buildUserProfile(),
        const SizedBox(width: 8),
      ],
    );
  }


  Widget _buildAppBarLogo() {
    return Image.asset(
      'assets/logo_image.png',
      height: 45,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.local_hospital,
            color: Colors.green,
            size: 24,
          ),
        );
      },
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Sanjeevika',
      style: TextStyle(
        color: Color(0xFF16833D),
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }


  Widget _buildUserProfile() {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF858585), width: 1),
        borderRadius: BorderRadius.circular(100),
        color: Colors.white,
      ),
      child: Row(
        children: [
          _buildUserAvatar(),
          const SizedBox(width: 6),
          _buildUserInfo(),
        ],
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF97DF4B), width: 1),
      ),
      child: const CircleAvatar(
        backgroundColor: Colors.white,
        radius: 14, // 👈 smaller avatar
        child: Icon(
          Icons.person_outline_outlined,
          color: Colors.grey,
          size: 16, // 👈 smaller icon
        ),
      ),
    );
  }


  Widget _buildUserInfo() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'John Marshall',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          '70 years old',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical:15),
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4F4),
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(
            color: Colors.redAccent,
            width: 5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNotificationHeader(),
          const SizedBox(height: 4),
          _buildNotificationMessage(),
        ],
      ),
    );
  }

  Widget _buildNotificationHeader() {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Text(
              "New Notification!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 11,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () => _dismissNotification(),
            child: const Icon(
              Icons.close,
              color: Colors.grey,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationMessage() {
    return const Text(
      " You missed your morning before-meal tablet.\nPlease take care next time 💊❤️. ",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.blueGrey,
      ),
    );
  }

  // Event handlers
  void _handleMenuPressed() {
    // Handle menu button press
    print('Menu button pressed');
    // You can implement drawer opening or navigation here
  }

  void _dismissNotification() {
    // Handle notification dismissal
    print('Notification dismissed');
    // You can implement notification dismissal logic here
  }
}