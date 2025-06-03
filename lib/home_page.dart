import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F8E0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFDEF1D8),
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {},
            ),
            Image.asset('assets/logo_sanjeevika.jpeg', height: 45),
            const SizedBox(width: 6),
            const Text(
              'Sanjeevika',
              style: TextStyle(
                color: Color(0xFF16833D),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF858585), width: 1),
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF97DF4B), width: 1),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'John Marshall',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '70 years old',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "New Notification!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        ),
                        Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Icon(Icons.notifications, color: Colors.red),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '"You missed your morning before-meal tablet.\n Please take care next time 💊❤️."',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              "Today’s Medications",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            MedicationCard(
              timeOfDay: "Morning",
              medicine: "Amoxicillin",
              dose: "500 mg",
              beforeMealStatus: "MISSED ❌",
              afterMealStatus: "TAKEN ✅",
              afterMealTime: "11:30 AM",
              isMissed: true,
            ),
            MedicationCard(
              timeOfDay: "Morning",
              medicine: "Amoxicillin",
              dose: "500 mg",
              beforeMealStatus: "TAKEN ✅",
              beforeMealTime: "12:30 PM",
              afterMealStatus: "TAKEN ✅",
              afterMealTime: "1:30 PM",
            ),
            MedicationCard(
              timeOfDay: "Morning",
              medicine: "Amoxicillin",
              dose: "500 mg",
              showButtons: true,
            ),
            // Quick Access Section moved here
            const SizedBox(height: 20),
            const Text(
              "QUICK ACCESS",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue[600],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: const [
                              Icon(Icons.calendar_today, color: Colors.white),
                              SizedBox(height: 8),
                              Text(
                                "Appointments",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "4 Active",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green[600],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: const [
                              Icon(Icons.medical_services, color: Colors.white),
                              SizedBox(height: 8),
                              Text(
                                "Refills",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "2 Due Soon",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.pink[400],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: const [
                              Icon(Icons.chat, color: Colors.white),
                              SizedBox(height: 8),
                              Text(
                                "AI Assistant",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Ask Anything",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red[600],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: const [
                              Icon(Icons.warning, color: Colors.white),
                              SizedBox(height: 8),
                              Text(
                                "EMERGENCY",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "SOS Help",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
    super.key,
    required this.timeOfDay,
    required this.medicine,
    required this.dose,
    this.beforeMealStatus,
    this.afterMealStatus,
    this.beforeMealTime,
    this.afterMealTime,
    this.isMissed = false,
    this.showButtons = false,
  });

  @override
  Widget build(BuildContext context) {
    Color getStatusColor(String status) {
      if (status.contains("MISSED")) return Colors.red[200]!;
      if (status.contains("TAKEN")) return Colors.green[300]!;
      return Colors.grey[200]!;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isMissed ? Colors.red[100]! : Colors.green[100]!,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(1, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Color(0xFFE0FFD9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  'assets/home_page_image.png',
                  width: 50,
                  height: 50,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    timeOfDay,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$medicine — $dose',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (showButtons)
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.green.shade100),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Before Meal",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding:
                              const EdgeInsets.symmetric(vertical: 10),
                            ),
                            onPressed: () {},
                            child: const Text("TAKE NOW"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 10),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.green.shade100),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "After Meal",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding:
                              const EdgeInsets.symmetric(vertical: 10),
                            ),
                            onPressed: () {},
                            child: const Text("TAKE NOW"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: getStatusColor(beforeMealStatus ?? ""),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const Text("Before Meal"),
                        Text(beforeMealStatus ?? ""),
                        if (beforeMealTime != null) Text(beforeMealTime!),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: getStatusColor(afterMealStatus ?? ""),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const Text("After Meal"),
                        Text(
                          afterMealStatus ?? "",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (afterMealTime != null) Text(afterMealTime!),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}