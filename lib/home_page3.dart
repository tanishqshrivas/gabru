import 'package:flutter/material.dart';

class TodaysMedicationsSection extends StatelessWidget {
  const TodaysMedicationsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title with green accent line
        _buildSectionTitle(),
        const SizedBox(height: 16),

        // List of medication cards
        _buildMedicationsList(),
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
          "Today's Medications",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget _buildMedicationsList() {
    return Column(
      children: [
        // First medication - with missed status
        MedicationCard(
          timeOfDay: "Morning",
          medicine: "Amoxicillin",
          dose: "500 mg",
          beforeMealStatus: "MISSED ❌",
          beforeMealTime: "9:00 AM",
          afterMealStatus: "TAKEN ✅",
          afterMealTime: "11:30 AM",
          isMissed: true,
        ),

        // Second medication - both taken
        MedicationCard(
          timeOfDay: "Afternoon",
          medicine: "Amoxicillin",
          dose: "500 mg",
          beforeMealStatus: "TAKEN ✅",
          beforeMealTime: "12:30 PM",
          afterMealStatus: "TAKEN ✅",
          afterMealTime: "1:30 PM",
        ),

        // Third medication - with action buttons
        MedicationCard(
          timeOfDay: "Evening",
          medicine: "Amoxicillin",
          dose: "500 mg",
          showButtons: true,
        ),
      ],
    );
  }
}

class MedicationCard extends StatelessWidget {
  final String timeOfDay;
  final String medicine;
  final String dose;
  final String? beforeMealStatus;
  final String? afterMealStatus;
  final String? beforeMealTime;
  final String? afterMealTime;
  final bool isMissed;
  final bool showButtons;

  const MedicationCard({
    Key? key,
    required this.timeOfDay,
    required this.medicine,
    required this.dose,
    this.beforeMealStatus,
    this.afterMealStatus,
    this.beforeMealTime,
    this.afterMealTime,
    this.isMissed = false,
    this.showButtons = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMedicationHeader(),
          const SizedBox(height: 16),
          _buildMedicationStatus(),
        ],
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _buildMedicationHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMedicationIcon(),
        const SizedBox(width: 12),
        _buildMedicationInfo(),
      ],
    );
  }

  Widget _buildMedicationIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(
        'assets/home_page_image.png',
        width: 40,
        height: 40,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.medication,
            size: 40,
            color: Colors.green,
          );
        },
      ),
    );
  }

  Widget _buildMedicationInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            timeOfDay,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$medicine — $dose',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.green.shade700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationStatus() {
    if (showButtons) {
      return _buildActionButtons();
    } else {
      return _buildStatusCards();
    }
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            title: "Before Meal",
            buttonText: "TAKE NOW",
            onPressed: () => _handleMedicationTaken("before"),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionCard(
            title: "After Meal",
            buttonText: "TAKE NOW",
            onPressed: () => _handleMedicationTaken("after"),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 2,
              ),
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatusCard(
            title: "Before Meal",
            status: beforeMealStatus,
            time: beforeMealTime,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatusCard(
            title: "After Meal",
            status: afterMealStatus,
            time: afterMealTime,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard({
    required String title,
    String? status,
    String? time,
  }) {
    final isMissedStatus = status?.contains("MISSED") ?? false;
    final isTakenStatus = status?.contains("TAKEN") ?? false;

    Color backgroundColor;
    Color borderColor;
    Color textColor;

    if (isMissedStatus) {
      backgroundColor = Colors.red.shade100;
      borderColor = Colors.red;
      textColor = Colors.red.shade700;
    } else if (isTakenStatus) {
      backgroundColor = Colors.green.shade100;
      borderColor = Colors.green;
      textColor = Colors.green.shade700;
    } else {
      backgroundColor = Colors.grey.shade200;
      borderColor = Colors.grey;
      textColor = Colors.grey.shade700;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          if (status != null)
            Text(
              status,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: textColor,
              ),
            ),
          if (time != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _handleMedicationTaken(String mealType) {
    // Handle medication taken action
    // This could trigger a callback to update the parent widget
    // or make an API call to record the medication intake
    print('Medication taken: $mealType meal - $medicine $dose');
  }
}