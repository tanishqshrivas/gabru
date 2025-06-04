import 'package:flutter/material.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE53935),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: -10, // This reduces the gap between leading and title
        title: Row(
          children: [
            const SizedBox(width: 4), // Optional: fine-tune spacing if needed
            const Icon(Icons.warning_amber_outlined, color: Colors.white, size: 25),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Emergency SOS',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Tap to call for help',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Emergency Services Section
            Row(
              children: [
                Icon(Icons.shield_outlined, color: Colors.red[600], size: 24),
                const SizedBox(width: 8),
                const Text(
                  'Quick Emergency Services',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Emergency Service Buttons
            Row(
              children: [
                Expanded(
                  child:
                  _buildEmergencyServiceButton(
                    context,
                    title: 'City Hospital Emergency',
                    subtitle: null,
                    number: '108',
                    color: const Color(0xFFE53935),
                    showIcon: true,
                    onTap: () => _showCallDialog(context, 'City Hospital Emergency', '108'),
                  ),

                ),

                const SizedBox(width: 12),
                Expanded(
                  child:
                  _buildEmergencyServiceButton(
                    context,
                    title: 'POLICE',
                    subtitle: 'Police Emergency',
                    number: '100',
                    color: const Color(0xFFE53935),
                    showIcon: false,
                    onTap: () => _showCallDialog(context, 'Police Emergency', '100'),
                  ),

                ),
              ],
            ),

                const SizedBox(height: 24),

            // All Emergency Contacts Section
            Row(
              children: [
                const Icon(Icons.phone_outlined, color: Colors.blue, size: 24),
                const SizedBox(width: 8),
                const Text(
                  'All Emergency Contacts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Emergency Contacts List
            _buildContactCard(
              context,
              name: 'Dr. Rajesh Sharma',
              role: 'Family Doctor',
              phone: '+91 9876543210',
              onTap: () => _showCallDialog(context, 'Dr. Rajesh Sharma', '+91 9876543210'),
            ),

            _buildContactCard(
              context,
              name: 'Dr. Rajesh Sharma',
              role: 'Family Doctor',
              phone: '+91 9876543210',
              onTap: () => _showCallDialog(context, 'Dr. Rajesh Sharma', '+91 9876543210'),
            ),

            _buildContactCard(
              context,
              name: 'Dr. Rajesh Sharma',
              role: 'Family Doctor',
              phone: '+91 9876543210',
              onTap: () => _showCallDialog(context, 'Dr. Rajesh Sharma', '+91 9876543210'),
            ),

            _buildContactCard(
              context,
              name: 'Dr. Rajesh Sharma',
              role: 'Family Doctor',
              phone: '+91 9876543210',
              onTap: () => _showCallDialog(context, 'Dr. Rajesh Sharma', '+91 9876543210'),
            ),

            _buildContactCard(
              context,
              name: 'Dr. Rajesh Sharma',
              role: 'Family Doctor',
              phone: '+91 9876543210',
              onTap: () => _showCallDialog(context, 'Dr. Rajesh Sharma', '+91 9876543210'),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildEmergencyServiceButton(
      BuildContext context, {
        required String title,
        String? subtitle,
        required String number,
        required Color color,
        required VoidCallback onTap,
        bool showIcon = false,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showIcon
                ? const Icon(Icons.local_hospital_rounded, color: Colors.white, size: 25)
                : Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            if (showIcon) // Show title only when icon is shown
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            if (subtitle != null)
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildContactCard(
      BuildContext context, {
        required String name,
        required String role,
        required String phone,
        required VoidCallback onTap,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE53935), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFFE0E0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.person_outline_outlined,
              color: Color(0xFFE53935),
            ),
          ),

          const SizedBox(width: 16),

          // Contact Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  role,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  phone,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Tap to call',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 80),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE0E0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.phone_outlined,
                    color: Color(0xFFE53935),
                    size: 20,
                  ),
                ),
              ),
            ],
          )

        ],
      ),
    );
  }


  void _showCallDialog(BuildContext context, String name, String number) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Circular icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEB),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.phone_outlined,
                    color: Color(0xFFE53935),
                    size: 50,
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                const Text(
                  'Confirm Emergency Call',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  'Are you sure you want to call?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),

                // Name Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFE0E0E0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child:
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Calling $name...')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF4D4D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.phone, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Call Now',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}