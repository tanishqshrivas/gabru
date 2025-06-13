import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmergencyContactsPage extends StatefulWidget {
  const EmergencyContactsPage({super.key});

  @override
  State<EmergencyContactsPage> createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
  List<EmergencyContact> contacts = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    contacts.add(EmergencyContact());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (var contact in contacts) {
      contact.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildModernHeader(context),
          Expanded(
            child: _buildContactsSection(),
          ),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildModernHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF16833D), Color(0xFF2EAD52)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Emergency Contacts',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  _buildAppLogo(),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Add trusted contacts for emergency situations',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: const Icon(
        Icons.local_hospital,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  Widget _buildContactsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (contacts.length > 1)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF16833D).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF16833D).withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFF16833D),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'You have ${contacts.length} emergency contact${contacts.length > 1 ? 's' : ''} configured',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF16833D),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return _buildEnhancedContactCard(index);
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildAddContactButton(),
        ],
      ),
    );
  }

  Widget _buildEnhancedContactCard(int index) {
    final contact = contacts[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.emergency,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Emergency Contact ${index + 1}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                  ],
                ),
                if (contacts.length > 1)
                  IconButton(
                    onPressed: () => _removeContact(index),
                    icon: const Icon(Icons.delete_outline),
                    color: Colors.red.shade400,
                    tooltip: 'Remove contact',
                  ),
              ],
            ),
            const SizedBox(height: 20),
            _buildStyledInputField(
              label: 'Contact Name',
              controller: contact.nameController,
              icon: Icons.person,
              hint: 'e.g., Dr. John Smith',
              validator: (value) => value?.isEmpty == true ? 'Name is required' : null,
            ),
            const SizedBox(height: 16),
            _buildStyledInputField(
              label: 'Phone Number',
              controller: contact.phoneController,
              icon: Icons.phone,
              hint: 'e.g., +91 98765 43210',
              keyboardType: TextInputType.phone,
              validator: (value) => value?.isEmpty == true ? 'Phone number is required' : null,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\s\(\)]')),
              ],
            ),
            const SizedBox(height: 16),
            _buildStyledInputField(
              label: 'Relationship',
              controller: contact.relationshipController,
              icon: Icons.family_restroom,
              hint: 'e.g., Family Doctor, Spouse, Friend',
              showDropdown: true,
              dropdownItems: const [
                'Family Doctor',
                'Personal Doctor',
                'Spouse',
                'Parent',
                'Child',
                'Sibling',
                'Friend',
                'Neighbor',
                'Other'
              ],
            ),
            if (contact.relationshipController.text == 'Family Doctor' ||
                contact.relationshipController.text == 'Personal Doctor')
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: _buildStyledInputField(
                  label: 'Medical Specialty (Optional)',
                  controller: contact.specialtyController,
                  icon: Icons.medical_services,
                  hint: 'e.g., Cardiologist, General Physician',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool showDropdown = false,
    List<String>? dropdownItems,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D2D2D),
          ),
        ),
        const SizedBox(height: 8),
        if (showDropdown && dropdownItems != null)
          DropdownButtonFormField<String>(
            value: controller.text.isEmpty ? null : controller.text,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              prefixIcon: Icon(icon, color: const Color(0xFF16833D), size: 20),
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF16833D), width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            items: dropdownItems.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                controller.text = newValue ?? '';
              });
            },
          )
        else
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              prefixIcon: Icon(icon, color: const Color(0xFF16833D), size: 20),
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF16833D), width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
      ],
    );
  }

  Widget _buildAddContactButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _addContact,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add Another Contact',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF16833D),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _saveContacts(context),
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text(
                  'Save Contacts',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16833D),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _backToHome(context),
                icon: const Icon(Icons.home, color: Colors.white),
                label: const Text(
                  'Back to Home',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addContact() {
    setState(() {
      contacts.add(EmergencyContact());
    });
    // Scroll to the new contact card
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _removeContact(int index) {
    if (contacts.length > 1) {
      setState(() {
        contacts[index].dispose();
        contacts.removeAt(index);
      });
    }
  }

  void _saveContacts(BuildContext context) {
    List<EmergencyContact> validContacts = contacts.where((contact) =>
    contact.nameController.text.isNotEmpty &&
        contact.phoneController.text.isNotEmpty).toList();

    if (validContacts.isEmpty) {
      _showErrorSnackBar(context, 'Please add at least one contact with name and phone number');
      return;
    }

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Save Emergency Contacts'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Save ${validContacts.length} emergency contact${validContacts.length > 1 ? 's' : ''}?'),
              const SizedBox(height: 12),
              ...validContacts.take(3).map((contact) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '• ${contact.nameController.text} (${contact.relationshipController.text.isEmpty ? 'Contact' : contact.relationshipController.text})',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              )),
              if (validContacts.length > 3)
                Text(
                  '... and ${validContacts.length - 3} more',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                _performSave(context, validContacts);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16833D),
                foregroundColor: Colors.white,
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _performSave(BuildContext context, List<EmergencyContact> validContacts) {
    // Here you would typically save to database or shared preferences
    print('Saving ${validContacts.length} emergency contacts');
    for (var contact in validContacts) {
      print('Contact: ${contact.nameController.text}, ${contact.phoneController.text}, ${contact.relationshipController.text}');
    }

    _showSuccessSnackBar(context, 'Emergency contacts saved successfully!');
  }

  void _backToHome(BuildContext context) {
    if (_hasUnsavedChanges()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Unsaved Changes'),
            content: const Text('You have unsaved changes. Do you want to go back without saving?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Go Back'),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  bool _hasUnsavedChanges() {
    return contacts.any((contact) =>
    contact.nameController.text.isNotEmpty ||
        contact.phoneController.text.isNotEmpty ||
        contact.relationshipController.text.isNotEmpty);
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFF16833D),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class EmergencyContact {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController relationshipController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();

  EmergencyContact({
    String name = '',
    String phone = '',
    String relationship = '',
    String specialty = '',
  }) {
    nameController.text = name;
    phoneController.text = phone;
    relationshipController.text = relationship;
    specialtyController.text = specialty;
  }

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    relationshipController.dispose();
    specialtyController.dispose();
  }
}