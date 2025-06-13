import 'package:flutter/material.dart';

import 'my_medicine.dart';
import 'my_profile.dart';
import 'emergency_contacts.dart';

class CustomSideBar extends StatelessWidget {
  const CustomSideBar({super.key});

  // Color constants for better maintainability
  static const Color _primaryGreen = Color(0xFF16833D);
  static const Color _lightGreen = Color(0xFFDEF1D8);
  static const Color _textColor = Color(0xFF2D3142);
  static const Color _iconColor = Color(0xFF16833D);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 8.0,
      child: Column(
        children: [
          // Elegant header with gradient and better typography
          _buildModernHeader(),

          // Main navigation area
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: _buildNavigationMenu(context),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a modern header with gradient background
  Widget _buildModernHeader() {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _lightGreen,
            _lightGreen.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: _primaryGreen.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App logo and name
              Row(
                children: [
                  _buildAppLogo(),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sanjeevika',
                          style: TextStyle(
                            color: _primaryGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          'Your Health Companion',
                          style: TextStyle(
                            color: _primaryGreen.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Welcome message or user info section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: _primaryGreen,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Stay healthy, stay happy!',
                      style: TextStyle(
                        color: _primaryGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the main navigation menu
  Widget _buildNavigationMenu(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),

        // Primary navigation items
        _buildMenuSection([
          _MenuItemData(
            icon: Icons.home_rounded,
            title: 'Home',
            onTap: () => _navigateToHome(context),
          ),
          _MenuItemData(
            icon: Icons.person_rounded,
            title: 'My Profile',
            onTap: () => _navigateToProfile(context),
          ),
          _MenuItemData(
            icon: Icons.medication_rounded,
            title: 'My Medicine',
            onTap: () => _navigateToMedicine(context),
          ),
          _MenuItemData(
            icon: Icons.emergency_rounded,
            title: 'Emergency Contacts',
            onTap: () => _navigateToEmergencyContacts(context),
          ),
        ]),

        // Divider for visual separation
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          height: 1,
          color: Colors.grey.shade200,
        ),

        // Secondary navigation items
        _buildMenuSection([
          _MenuItemData(
            icon: Icons.settings_rounded,
            title: 'Settings',
            onTap: () => _navigateToSettings(context),
          ),
        ]),

        const Spacer(),

        // Logout section at bottom
        Container(
          margin: const EdgeInsets.all(16),
          child: _buildLogoutButton(context),
        ),
      ],
    );
  }

  /// Builds a section of menu items
  Widget _buildMenuSection(List<_MenuItemData> items) {
    return Column(
      children: items.map((item) => _buildEnhancedMenuItem(
        icon: item.icon,
        title: item.title,
        onTap: item.onTap,
      )).toList(),
    );
  }

  /// Creates an enhanced menu item with better styling
  Widget _buildEnhancedMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          splashColor: _lightGreen.withOpacity(0.3),
          highlightColor: _lightGreen.withOpacity(0.2),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _lightGreen.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: _iconColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: _textColor,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Creates a stylish logout button
  Widget _buildLogoutButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _handleLogout(context),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red.shade200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.logout_rounded,
                  color: Colors.red.shade600,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.red.shade600,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Creates an enhanced app logo
  Widget _buildAppLogo() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _primaryGreen.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/logo_image.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_primaryGreen, _primaryGreen.withOpacity(0.8)],
                ),
              ),
              child: const Icon(
                Icons.local_hospital_rounded,
                color: Colors.white,
                size: 32,
              ),
            );
          },
        ),
      ),
    );
  }

  // Navigation Methods
  void _navigateToHome(BuildContext context) {
    Navigator.pop(context);
    debugPrint('Navigating to Home');
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const MyProfilePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
            ),
            child: child,
          );
        },
      ),
    );
  }

  void _navigateToMedicine(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const MyMedicinePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
            ),
            child: child,
          );
        },
      ),
    );
  }

  void _navigateToEmergencyContacts(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const EmergencyContactsPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
            ),
            child: child,
          );
        },
      ),
    );
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.pop(context);
    debugPrint('Navigating to Settings');
    // TODO: Implement settings page navigation
    // Navigator.pushNamed(context, '/settings');
  }

  void _handleLogout(BuildContext context) {
    Navigator.pop(context);
    _showModernLogoutDialog(context);
  }

  /// Shows a modern, styled logout confirmation dialog
  void _showModernLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.logout_rounded,
                  color: Colors.red.shade600,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: const Text(
            'Are you sure you want to logout? You\'ll need to sign in again to access your account.',
            style: TextStyle(
              fontSize: 16,
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _performLogout(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Performs the actual logout operation
  void _performLogout(BuildContext context) {
    debugPrint('User logged out successfully');

    // TODO: Implement actual logout logic here:
    // - Clear user session/tokens
    // - Clear stored user data
    // - Navigate to login screen
    // - Show success message

    // Example implementation:
    // await UserSession.clearSession();
    // Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);

    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Logged out successfully'),
        backgroundColor: _primaryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

/// Data class for menu items to improve code organization
class _MenuItemData {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuItemData({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}