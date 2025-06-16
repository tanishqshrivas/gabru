import 'package:flutter/material.dart';
import 'package:project/appointment_page.dart';
import 'package:project/refill_page.dart';
import 'ai_page.dart';
import 'emergency.dart';

class QuickAccessSection extends StatelessWidget {
  const QuickAccessSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title with green accent line
        _buildSectionTitle(),
        const SizedBox(height: 16),

        // First row: Appointments and Refills
        _buildFirstRow(context),
        const SizedBox(height: 12),

        // Second row: AI Assistant and Emergency
        _buildSecondRow(context),
      ],
    );
  }

  Widget _buildSectionTitle() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.green,
            width: 4,
          ),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.only(left: 12),
        child: Text(
          "Quick Access",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }

  Widget _buildFirstRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildQuickAccessCard(
            context: context,
            backgroundColor: Color(0xFF160DFF),
            icon: Icons.calendar_today_outlined,
            title: "Appointments",
            subtitle: "4 Active",
            onTap: () => _navigateToPage(context, const AppointmentPage()),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickAccessCard(
            context: context,
            backgroundColor: Color(0xFF00C907),
            icon: Icons.medical_information_outlined,
            title: "Refills",
            subtitle: "2 Due Soon",
            onTap: () => _navigateToPage(context, const RefillPage()),
          ),
        ),
      ],
    );
  }

  Widget _buildSecondRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildQuickAccessCard(
            context: context,
            backgroundColor: Color(0xFFFF00E5),
            icon: Icons.chat_bubble_outline_outlined,
            title: "AI Assistant",
            subtitle: "Ask Anything",
            onTap: () => _navigateToPage(context, const AiPage()),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickAccessCard(
            context: context,
            backgroundColor: Color(0xFFFF0000),
            icon: Icons.warning_amber_outlined,
            iconColor: Colors.red,
            title: "EMERGENCY",
            subtitle: "SOS Help",
            onTap: () => _navigateToPage(context, const EmergencyPage()),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAccessCard({
    required BuildContext context,
    required Color backgroundColor,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: iconColor ?? Colors.green,
                  size: 32,
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}