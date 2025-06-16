import 'package:flutter/material.dart';

class TodaysMedicationsSection extends StatefulWidget {
  const TodaysMedicationsSection({Key? key}) : super(key: key);

  @override
  State<TodaysMedicationsSection> createState() => _TodaysMedicationsSectionState();
}

class _TodaysMedicationsSectionState extends State<TodaysMedicationsSection> {
  // Track medication statuses
  Map<String, MedicationStatus> medicationStatuses = {};

  @override
  void initState() {
    super.initState();
    _initializeMedicationStatuses();
    _startTimeChecker();
  }

  void _initializeMedicationStatuses() {
    // Initialize all medications with pending status
    medicationStatuses = {
      'morning_before': MedicationStatus(
        scheduledTime: TimeOfDay(hour: 9, minute: 0),
        status: MedicationStatusType.pending,
      ),
      'morning_after': MedicationStatus(
        scheduledTime: TimeOfDay(hour: 11, minute: 30),
        status: MedicationStatusType.pending,
      ),
      'afternoon_before': MedicationStatus(
        scheduledTime: TimeOfDay(hour: 12, minute: 30),
        status: MedicationStatusType.pending,
      ),
      'afternoon_after': MedicationStatus(
        scheduledTime: TimeOfDay(hour: 13, minute: 30),
        status: MedicationStatusType.pending,
      ),
      'evening_before': MedicationStatus(
        scheduledTime: TimeOfDay(hour: 18, minute: 0),
        status: MedicationStatusType.pending,
      ),
      'evening_after': MedicationStatus(
        scheduledTime: TimeOfDay(hour: 20, minute: 0),
        status: MedicationStatusType.pending,
      ),
    };
  }

  void _startTimeChecker() {
    // Check every minute if any medications should be marked as missed
    Future.delayed(Duration(minutes: 1), () {
      if (mounted) {
        _checkForMissedMedications();
        _startTimeChecker();
      }
    });
  }

  void _checkForMissedMedications() {
    final now = TimeOfDay.now();
    bool shouldUpdate = false;

    medicationStatuses.forEach((key, medication) {
      if (medication.status == MedicationStatusType.pending &&
          _isTimePassed(now, medication.scheduledTime)) {
        medication.status = MedicationStatusType.missed;
        shouldUpdate = true;
      }
    });

    if (shouldUpdate) {
      setState(() {});
    }
  }

  bool _isTimePassed(TimeOfDay current, TimeOfDay scheduled) {
    final currentMinutes = current.hour * 60 + current.minute;
    final scheduledMinutes = scheduled.hour * 60 + scheduled.minute;
    return currentMinutes > scheduledMinutes;
  }

  void _handleMedicationTaken(String medicationKey) {
    final now = TimeOfDay.now();
    final medication = medicationStatuses[medicationKey]!;

    setState(() {
      // Always mark as taken when button is pressed (button only shows when time hasn't passed)
      medication.status = MedicationStatusType.taken;
      medication.takenTime = now;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(),
        const SizedBox(height: 16),
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
        MedicationCard(
          timeOfDay: "Morning",
          medicine: "Amoxicillin",
          dose: "500 mg",
          beforeMealStatus: medicationStatuses['morning_before']!,
          afterMealStatus: medicationStatuses['morning_after']!,
          onMedicationTaken: _handleMedicationTaken,
          beforeMealKey: 'morning_before',
          afterMealKey: 'morning_after',
        ),
        MedicationCard(
          timeOfDay: "Afternoon",
          medicine: "Amoxicillin",
          dose: "500 mg",
          beforeMealStatus: medicationStatuses['afternoon_before']!,
          afterMealStatus: medicationStatuses['afternoon_after']!,
          onMedicationTaken: _handleMedicationTaken,
          beforeMealKey: 'afternoon_before',
          afterMealKey: 'afternoon_after',
        ),
        MedicationCard(
          timeOfDay: "Evening",
          medicine: "Amoxicillin",
          dose: "500 mg",
          beforeMealStatus: medicationStatuses['evening_before']!,
          afterMealStatus: medicationStatuses['evening_after']!,
          onMedicationTaken: _handleMedicationTaken,
          beforeMealKey: 'evening_before',
          afterMealKey: 'evening_after',
        ),
      ],
    );
  }
}

enum MedicationStatusType { pending, taken, missed }

class MedicationStatus {
  TimeOfDay scheduledTime;
  MedicationStatusType status;
  TimeOfDay? takenTime;

  MedicationStatus({
    required this.scheduledTime,
    required this.status,
    this.takenTime,
  });
}

class MedicationCard extends StatelessWidget {
  final String timeOfDay;
  final String medicine;
  final String dose;
  final MedicationStatus beforeMealStatus;
  final MedicationStatus afterMealStatus;
  final Function(String) onMedicationTaken;
  final String beforeMealKey;
  final String afterMealKey;

  const MedicationCard({
    Key? key,
    required this.timeOfDay,
    required this.medicine,
    required this.dose,
    required this.beforeMealStatus,
    required this.afterMealStatus,
    required this.onMedicationTaken,
    required this.beforeMealKey,
    required this.afterMealKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: _buildCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMedicationHeader(),
          const SizedBox(height: 10),
          _buildMedicationStatus(),
        ],
      ),
    );
  }

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 6,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }

  Widget _buildMedicationHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMedicationIcon(),
        const SizedBox(width: 10),
        _buildMedicationInfo(),
      ],
    );
  }

  Widget _buildMedicationIcon() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.medication,
        size: 30,
        color: Colors.green,
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
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '$medicine — $dose',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF22C55E),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationStatus() {
    return Row(
      children: [
        Expanded(
          child: _buildMedicationTile(
            title: "Before Meal",
            status: beforeMealStatus,
            scheduledTime: _formatTime(beforeMealStatus.scheduledTime),
            onTakeNow: () => onMedicationTaken(beforeMealKey),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildMedicationTile(
            title: "After Meal",
            status: afterMealStatus,
            scheduledTime: _formatTime(afterMealStatus.scheduledTime),
            onTakeNow: () => onMedicationTaken(afterMealKey),
          ),
        ),
      ],
    );
  }

  Widget _buildMedicationTile({
    required String title,
    required MedicationStatus status,
    required String scheduledTime,
    required VoidCallback onTakeNow,
  }) {
    final now = TimeOfDay.now();
    final isTimePassed = _isTimePassed(now, status.scheduledTime);

    Color backgroundColor;
    Color borderColor;
    Widget statusWidget;

    if (status.status == MedicationStatusType.pending && isTimePassed) {
      backgroundColor = Color(0xFFFFDFDF);
      borderColor = Color(0xFFFCA5A5);
      statusWidget = _buildStatusText(title, 'MISSED ❌', Color(0xFFFF0000), scheduledTime);
    } else {
      switch (status.status) {
        case MedicationStatusType.pending:
          backgroundColor = Color(0xFFFFEFD7);
          borderColor = Color(0xFFFDBA74);
          statusWidget = Column(
            children: [
              Text(title, style: _titleStyle()),
              Text('Due: $scheduledTime', style: _timeStyle()),
              const SizedBox(height: 6),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF86D1C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  minimumSize: const Size.fromHeight(30),
                ),
                onPressed: onTakeNow,
                child: const Text('TAKE NOW', style: TextStyle(fontSize: 11)),
              ),
            ],
          );
          break;
        case MedicationStatusType.taken:
          backgroundColor = Color(0xFFB7FF80);
          borderColor = Color(0xFF86EFAC);
          statusWidget = Column(
            children: [
              Text(title, style: _titleStyle()),
              const SizedBox(height: 6),
              Text('TAKEN ✅', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Color(0xFF1C4600))),
              if (status.takenTime != null)
                Text('at ${_formatTime(status.takenTime!)}', style: _timeStyle()),
            ],
          );
          break;
        case MedicationStatusType.missed:
          backgroundColor = Colors.red.shade100;
          borderColor = Colors.red;
          statusWidget = _buildStatusText(title, 'MISSED ❌', Colors.red.shade700, scheduledTime);
          break;
      }
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: statusWidget,
    );
  }

  Widget _buildStatusText(String title, String status, Color color, String scheduledTime) {
    return Column(
      children: [
        Text(title, style: _titleStyle()),
        const SizedBox(height: 6),
        Text(status, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color)),
        Text('Due: $scheduledTime', style: _timeStyle()),
      ],
    );
  }

  TextStyle _titleStyle() => const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87);
  TextStyle _timeStyle() => TextStyle(fontSize: 11, color: Colors.grey.shade600);

  bool _isTimePassed(TimeOfDay current, TimeOfDay scheduled) {
    final currentMinutes = current.hour * 60 + current.minute;
    final scheduledMinutes = scheduled.hour * 60 + scheduled.minute;
    return currentMinutes > scheduledMinutes;
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}
