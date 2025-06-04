import 'package:flutter/material.dart';

class RefillPage extends StatefulWidget {
  const RefillPage({super.key});

  @override
  State<RefillPage> createState() => _RefillPageState();
}

class _RefillPageState extends State<RefillPage> {
  bool showSuccessNotification = false;
  int selectedQuantity = 1;
  int orderedQuantity = 0; // Add this to track the ordered quantity

  void _showQuantityDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Color(0xFF4CAF50),
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Select Quantity',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Metformin 500mg',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Diabetes',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const Text(
                      '2 tablets daily',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (selectedQuantity > 1) {
                                setDialogState(() {
                                  selectedQuantity--;
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.remove,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          Text(
                            selectedQuantity.toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 24),
                          GestureDetector(
                            onTap: () {
                              setDialogState(() {
                                selectedQuantity++;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Requesting $selectedQuantity pack(s) of Metformin 500mg',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                selectedQuantity = 1;
                              });
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                orderedQuantity = selectedQuantity; // Store the ordered quantity
                                showSuccessNotification = true;
                              });
                              // Hide notification after 3 seconds
                              Future.delayed(const Duration(seconds: 3), () {
                                if (mounted) {
                                  setState(() {
                                    showSuccessNotification = false;
                                  });
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4CAF50),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.check, color: Colors.white, size: 18),
                                SizedBox(width: 4),
                                Text(
                                  'OK',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F8E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Medicine Refills',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Request prescription refills',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: const Color(0xFFF0F8E0),
                child: Row(
                  children: const [
                    Icon(Icons.local_pharmacy_outlined, color: Color(0xFF4CAF50)),
                    SizedBox(width: 8),
                    Text(
                      'All Prescribed Medicines',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
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
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.medication_outlined,
                              color: Color(0xFF2196F3),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Amlodipine 5mg',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Blood Pressure · 1 tablet daily',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showQuantityDialog();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Tap to order',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 50),
                          const Icon(
                            Icons.medical_information_outlined,
                            color: Color(0xFF2196F3),
                            size: 30,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          // Success notification overlay
          if (showSuccessNotification)
            Positioned(
              top: 20,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Color(0xFF4CAF50),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Order Placed Successfully!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Amlodipine 5mg · $orderedQuantity pack(s) ordered', // Updated to show actual ordered quantity
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}