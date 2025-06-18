import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class InformationForm extends StatefulWidget {
  @override
  _InformationFormState createState() => _InformationFormState();
}

class _InformationFormState extends State<InformationForm> {
  final _formKey = GlobalKey<FormState>();

  // Personal Information Controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();

  String _selectedBloodGroup = '';
  final List<String> _bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  // Profile Image
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // Disease and Medicine Information
  List<DiseaseInfo> _diseases = [DiseaseInfo()];

  // Emergency Contacts
  List<EmergencyContact> _emergencyContacts = [EmergencyContact()];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Profile Picture',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _getImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.linked_camera_outlined,
                            size: 30,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('Camera'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.photo_library_outlined,
                            size: 30,
                            color: Colors.green.shade700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('Gallery'),
                      ],
                    ),
                  ),
                  if (_profileImage != null)
                    GestureDetector(
                      onTap: () {
                        _removeImage();
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.delete,
                              size: 30,
                              color: Colors.red.shade700,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('Remove'),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );
      if (image != null) {
        setState(() {
          _profileImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeImage() {
    setState(() {
      _profileImage = null;
    });
  }

  void _addDisease() {
    setState(() {
      _diseases.add(DiseaseInfo());
    });
  }

  void _removeDisease(int index) {
    if (_diseases.length > 1) {
      setState(() {
        _diseases.removeAt(index);
      });
    }
  }

  void _addEmergencyContact() {
    setState(() {
      _emergencyContacts.add(EmergencyContact());
    });
  }

  void _removeEmergencyContact(int index) {
    if (_emergencyContacts.length > 1) {
      setState(() {
        _emergencyContacts.removeAt(index);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Collect all form data
      Map<String, dynamic> formData = {
        'personalInfo': {
          'name': _nameController.text,
          'bloodGroup': _selectedBloodGroup,
          'phone': _phoneController.text,
          'dateOfBirth': _dobController.text,
          'profileImagePath': _profileImage?.path ?? 'profile_image.png',
        },
        'diseases': _diseases.map((disease) => disease.toMap()).toList(),
        'emergencyContacts': _emergencyContacts.map((contact) => contact.toMap()).toList(),
      };

      // TODO: Save data to database or send to API
      print('Form Data: $formData');

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Information saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to home page
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Widget _buildProfileImageSection() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Center(
        child: GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
              border: Border.all(
                color: Colors.green.shade300,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: _profileImage != null
                ? ClipOval(
              child: Image.file(
                _profileImage!,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            )
                : ClipOval(
              child: Image.asset(
                'assets/images/profile_image.png',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.grey.shade600,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Health Information',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.green.shade900,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.green.shade900),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image Section
              _buildProfileImageSection(),

              // Personal Information Section
              _buildSectionHeader('Personal Information', Icons.person, Colors.blue),
              _buildPersonalInfoSection(),

              SizedBox(height: 30),

              // Medical Information Section
              _buildSectionHeader('Medical Information', Icons.medical_services, Colors.green),
              _buildMedicalInfoSection(),

              SizedBox(height: 30),

              // Emergency Contacts Section
              _buildSectionHeader('Emergency Contacts', Icons.emergency, Colors.red),
              _buildEmergencyContactsSection(),

              SizedBox(height: 40),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Save Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Full Name *',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: Icon(Icons.person_outline),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(height: 15),

          DropdownButtonFormField<String>(
            value: _selectedBloodGroup.isEmpty ? null : _selectedBloodGroup,
            decoration: InputDecoration(
              labelText: 'Blood Group *',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: Icon(Icons.bloodtype_outlined),
            ),
            items: _bloodGroups.map((String group) {
              return DropdownMenuItem<String>(
                value: group,
                child: Text(group),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedBloodGroup = newValue!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select blood group';
              }
              return null;
            },
          ),
          SizedBox(height: 15),

          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: Icon(Icons.phone_outlined),
            ),
          ),
          SizedBox(height: 15),

          TextFormField(
            controller: _dobController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Date of Birth *',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: Icon(Icons.calendar_today_outlined),
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_month),
                onPressed: _selectDate,
              ),
            ),
            onTap: _selectDate,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select date of birth';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalInfoSection() {
    return Column(
      children: [
        ..._diseases.asMap().entries.map((entry) {
          int index = entry.key;
          DiseaseInfo disease = entry.value;
          return _buildDiseaseCard(disease, index);
        }).toList(),
        SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: _addDisease,
          icon: Icon(Icons.add),
          label: Text('Add Disease'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade100,
            foregroundColor: Colors.green.shade700,
            elevation: 0,
          ),
        ),
      ],
    );
  }

  Widget _buildDiseaseCard(DiseaseInfo disease, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Disease ${index + 1}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade700,
                ),
              ),
              if (_diseases.length > 1)
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => _removeDisease(index),
                ),
            ],
          ),
          SizedBox(height: 15),

          TextFormField(
            controller: disease.nameController,
            decoration: InputDecoration(
              labelText: 'Disease Name *',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: Icon(Icons.local_hospital_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter disease name';
              }
              return null;
            },
          ),
          SizedBox(height: 20),

          Text(
            'Medicines',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 10),

          ...disease.medicines.asMap().entries.map((entry) {
            int medIndex = entry.key;
            Medicine medicine = entry.value;
            return _buildMedicineCard(disease, medicine, medIndex);
          }).toList(),

          SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () => disease.addMedicine(),
            icon: Icon(Icons.add, size: 16),
            label: Text('Add Medicine'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade50,
              foregroundColor: Colors.blue.shade700,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicineCard(DiseaseInfo disease, Medicine medicine, int medIndex) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Medicine ${medIndex + 1}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              if (disease.medicines.length > 1)
                IconButton(
                  icon: Icon(Icons.close, color: Colors.red, size: 20),
                  onPressed: () => setState(() {
                    disease.removeMedicine(medIndex);
                  }),
                ),
            ],
          ),
          SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: medicine.nameController,
                  decoration: InputDecoration(
                    labelText: 'Medicine Name *',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: medicine.quantityController,
                  decoration: InputDecoration(
                    labelText: 'Quantity *',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 15),

          // Meal Timing
          Text('Meal Timing:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: Text('Before Meal', style: TextStyle(fontSize: 12)),
                  value: medicine.beforeMeal,
                  onChanged: (value) => setState(() {
                    medicine.beforeMeal = value!;
                  }),
                  dense: true,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text('After Meal', style: TextStyle(fontSize: 12)),
                  value: medicine.afterMeal,
                  onChanged: (value) => setState(() {
                    medicine.afterMeal = value!;
                  }),
                  dense: true,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            ],
          ),

          // Time of Day
          Text('Time of Day:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: Text('Morning', style: TextStyle(fontSize: 12)),
                  value: medicine.morning,
                  onChanged: (value) => setState(() {
                    medicine.morning = value!;
                  }),
                  dense: true,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text('Afternoon', style: TextStyle(fontSize: 12)),
                  value: medicine.afternoon,
                  onChanged: (value) => setState(() {
                    medicine.afternoon = value!;
                  }),
                  dense: true,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  title: Text('Evening', style: TextStyle(fontSize: 12)),
                  value: medicine.evening,
                  onChanged: (value) => setState(() {
                    medicine.evening = value!;
                  }),
                  dense: true,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContactsSection() {
    return Column(
      children: [
        ..._emergencyContacts.asMap().entries.map((entry) {
          int index = entry.key;
          EmergencyContact contact = entry.value;
          return _buildEmergencyContactCard(contact, index);
        }).toList(),
        SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: _addEmergencyContact,
          icon: Icon(Icons.add),
          label: Text('Add Emergency Contact'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade100,
            foregroundColor: Colors.red.shade700,
            elevation: 0,
          ),
        ),
      ],
    );
  }

  Widget _buildEmergencyContactCard(EmergencyContact contact, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Emergency Contact ${index + 1}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade700,
                ),
              ),
              if (_emergencyContacts.length > 1)
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => _removeEmergencyContact(index),
                ),
            ],
          ),
          SizedBox(height: 15),

          TextFormField(
            controller: contact.nameController,
            decoration: InputDecoration(
              labelText: 'Contact Name *',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: Icon(Icons.person_outline),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter contact name';
              }
              return null;
            },
          ),
          SizedBox(height: 15),

          TextFormField(
            controller: contact.phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Phone Number *',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              prefixIcon: Icon(Icons.phone_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter phone number';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

// Data Models
class DiseaseInfo {
  final TextEditingController nameController = TextEditingController();
  List<Medicine> medicines = [Medicine()];

  void addMedicine() {
    medicines.add(Medicine());
  }

  void removeMedicine(int index) {
    if (medicines.length > 1) {
      medicines.removeAt(index);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': nameController.text,
      'medicines': medicines.map((medicine) => medicine.toMap()).toList(),
    };
  }

  void dispose() {
    nameController.dispose();
    for (Medicine medicine in medicines) {
      medicine.dispose();
    }
  }
}

class Medicine {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  bool beforeMeal = false;
  bool afterMeal = false;
  bool morning = false;
  bool afternoon = false;
  bool evening = false;

  Map<String, dynamic> toMap() {
    return {
      'name': nameController.text,
      'quantity': quantityController.text,
      'timing': {
        'beforeMeal': beforeMeal,
        'afterMeal': afterMeal,
        'morning': morning,
        'afternoon': afternoon,
        'evening': evening,
      },
    };
  }

  void dispose() {
    nameController.dispose();
    quantityController.dispose();
  }
}

class EmergencyContact {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Map<String, dynamic> toMap() {
    return {
      'name': nameController.text,
      'phone': phoneController.text,
    };
  }

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
  }
}