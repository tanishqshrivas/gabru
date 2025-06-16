import 'package:flutter/material.dart';
import 'home_page2.dart'; // QuickAccessSection
import 'home_page3.dart'; // TodaysMedicationsSection
import 'side_bar.dart'; // CustomSideBar

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FFEE),
      appBar: _buildAppBar(),
      drawer: const CustomSideBar(), // Using the custom sidebar
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 1),
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
      automaticallyImplyLeading: true,
      backgroundColor: const Color(0xFFE5FFE5),
      elevation: 0,
      titleSpacing: -10, // no extra spacing before logo
      title: Row(
        children: [
          const SizedBox(width: 4), // tighter spacing near the sidebar icon
          _buildAppBarLogo(),
          const SizedBox(width: 4),
          const Text(
            'Sanjeevika',
            style: TextStyle(
              color: Color(0xFF005014),
              fontWeight: FontWeight.w400,
              fontSize: 25,
            ),
          ),
          const Spacer(),
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
      height: 54,
      width: 57,
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


  Widget _buildUserProfile() {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), // more height
      decoration: BoxDecoration(
        color: const Color(0xFFE8FAE7), // soft green
        border: Border.all(color: const Color(0xFF97DF4B), width: 1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/profile_image.png',
              width: 28,
              height: 28,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'John Marshall',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color(0xFF003313),
                ),
              ),
              Text(
                '70 years old',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF5C5C5C),
                ),
              ),
            ],
          ),
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
        radius: 14,
        child: Icon(
          Icons.person_outline_outlined,
          color: Colors.grey,
          size: 30,
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
            color: Color(0xFF003313),
          ),
        ),
        Text(
          '70 years old',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF494949),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                fontWeight: FontWeight.w600,
                color: Color(0xFFBF1818),
                fontSize: 10,
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
    " You missed your morning before-meal tablet. Please take care next time 💊❤️. ",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Color(0xFF454545),
      ),
    );
  }

  // Event handlers
  void _dismissNotification() {
    print('Notification dismissed');
  }
}