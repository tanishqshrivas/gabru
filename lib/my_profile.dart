import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage>
    with SingleTickerProviderStateMixin {
  // Form and animation controllers
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Text controllers with proper organization
  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'dob': TextEditingController(),
    'gender': TextEditingController(),
    'bloodGroup': TextEditingController(),
    'mobile': TextEditingController(),
    'age': TextEditingController(),
    'email': TextEditingController(),
    'address': TextEditingController(),
  };

  // UI state variables
  File? _profileImage;
  bool _isLoading = false;
  bool _isEditing = false;
  String? _selectedGender;
  String? _selectedBloodGroup;

  // Color constants
  static const Color _primaryGreen = Color(0xFF16833D);
  static const Color _lightGreen = Color(0xFFDEF1D8);
  static const Color _textColor = Color(0xFF2D3142);

  // Dropdown options
  static const List<String> _genderOptions = ['Male', 'Female', 'Other'];
  static const List<String> _bloodGroupOptions = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadUserData();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  /// Load existing user data (placeholder for actual implementation)
  void _loadUserData() {
    // TODO: Load user data from database/preferences
    // For demo purposes, pre-filling some data
    _controllers['name']?.text = 'John Doe';
    _controllers['email']?.text = 'john.doe@example.com';
    _selectedGender = 'Male';
    _selectedBloodGroup = 'O+';
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          _buildModernHeader(context),
          Expanded(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildProfileContent(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Builds modern header with enhanced styling
  Widget _buildModernHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_lightGreen, _lightGreen.withOpacity(0.8)],
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              // Back button with enhanced styling
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () => _handleBackPress(context),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: _primaryGreen,
                    size: 24,
                  ),
                ),
              ),

              // Title section
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'My Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _primaryGreen,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'Manage your personal information',
                      style: TextStyle(
                        fontSize: 14,
                        color: _primaryGreen.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // Edit/Save toggle button
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: _toggleEditMode,
                  icon: Icon(
                    _isEditing ? Icons.save_rounded : Icons.edit_rounded,
                    color: _primaryGreen,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the main profile content
  Widget _buildProfileContent() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile image section
                _buildProfileImageSection(),
                const SizedBox(height: 32),

                // Personal information section
                _buildSectionHeader('Personal Information'),
                const SizedBox(height: 16),
                _buildPersonalInfoFields(),

                const SizedBox(height: 32),

                // Contact information section
                _buildSectionHeader('Contact Information'),
                const SizedBox(height: 16),
                _buildContactInfoFields(),

                const SizedBox(height: 32),

                // Medical information section
                _buildSectionHeader('Medical Information'),
                const SizedBox(height: 16),
                _buildMedicalInfoFields(),

                const SizedBox(height: 40),

                // Action buttons
                if (_isEditing) _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the profile image section with enhanced styling
  Widget _buildProfileImageSection() {
    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _primaryGreen.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: _lightGreen,
              backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
              child: _profileImage == null
                  ? Icon(
                Icons.person_rounded,
                size: 60,
                color: _primaryGreen.withOpacity(0.7),
              )
                  : null,
            ),
          ),
          if (_isEditing)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _showImagePickerDialog,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _primaryGreen,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Builds section headers
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: _textColor,
        letterSpacing: 0.3,
      ),
    );
  }

  /// Builds personal information fields
  Widget _buildPersonalInfoFields() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildEnhancedInputField(
                'Full Name',
                _controllers['name']!,
                icon: Icons.person_rounded,
                enabled: _isEditing,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildEnhancedInputField(
                'Age',
                _controllers['age']!,
                icon: Icons.cake_rounded,
                keyboardType: TextInputType.number,
                enabled: _isEditing,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildEnhancedInputField(
          'Date of Birth',
          _controllers['dob']!,
          icon: Icons.calendar_today_rounded,
          enabled: _isEditing,
          readOnly: true,
          onTap: _isEditing ? () => _selectDate(context) : null,
        ),
        const SizedBox(height: 16),
        _buildGenderDropdown(),
      ],
    );
  }

  /// Builds contact information fields
  Widget _buildContactInfoFields() {
    return Column(
      children: [
        _buildEnhancedInputField(
          'Email Address',
          _controllers['email']!,
          icon: Icons.email_rounded,
          keyboardType: TextInputType.emailAddress,
          enabled: _isEditing,
        ),
        const SizedBox(height: 16),
        _buildEnhancedInputField(
          'Mobile Number',
          _controllers['mobile']!,
          icon: Icons.phone_rounded,
          keyboardType: TextInputType.phone,
          enabled: _isEditing,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 16),
        _buildEnhancedInputField(
          'Address',
          _controllers['address']!,
          icon: Icons.location_on_rounded,
          enabled: _isEditing,
          maxLines: 3,
        ),
      ],
    );
  }

  /// Builds medical information fields
  Widget _buildMedicalInfoFields() {
    return Column(
      children: [
        _buildBloodGroupDropdown(),
      ],
    );
  }

  /// Enhanced input field with better styling
  Widget _buildEnhancedInputField(
      String label,
      TextEditingController controller, {
        IconData? icon,
        TextInputType keyboardType = TextInputType.text,
        bool enabled = true,
        bool readOnly = false,
        VoidCallback? onTap,
        List<TextInputFormatter>? inputFormatters,
        int maxLines = 1,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      readOnly: readOnly,
      onTap: onTap,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: 16,
        color: enabled ? _textColor : Colors.grey.shade600,
        fontWeight: FontWeight.w500,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter $label';
        }
        if (label == 'Email Address' && !_isValidEmail(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: enabled ? _primaryGreen : Colors.grey.shade500,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: icon != null
            ? Icon(
          icon,
          color: enabled ? _primaryGreen : Colors.grey.shade400,
          size: 22,
        )
            : null,
        filled: true,
        fillColor: enabled ? Colors.grey.shade50 : Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _primaryGreen, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  /// Builds gender dropdown
  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,

      decoration: InputDecoration(
        labelText: 'Gender',
        labelStyle: TextStyle(
          color: _isEditing ? _primaryGreen : Colors.grey.shade500,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          Icons.wc_rounded,
          color: _isEditing ? _primaryGreen : Colors.grey.shade400,
          size: 22,
        ),
        filled: true,
        fillColor: _isEditing ? Colors.grey.shade50 : Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _primaryGreen, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      items: _genderOptions.map((String gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      onChanged: _isEditing ? (String? newValue) {
        setState(() {
          _selectedGender = newValue;
        });
      } : null,
      validator: (value) => value == null ? 'Please select gender' : null,
    );
  }

  /// Builds blood group dropdown
  Widget _buildBloodGroupDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedBloodGroup,

      decoration: InputDecoration(
        labelText: 'Blood Group',
        labelStyle: TextStyle(
          color: _isEditing ? _primaryGreen : Colors.grey.shade500,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          Icons.bloodtype_rounded,
          color: _isEditing ? _primaryGreen : Colors.grey.shade400,
          size: 22,
        ),
        filled: true,
        fillColor: _isEditing ? Colors.grey.shade50 : Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _primaryGreen, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      items: _bloodGroupOptions.map((String bloodGroup) {
        return DropdownMenuItem<String>(
          value: bloodGroup,
          child: Text(bloodGroup),
        );
      }).toList(),
      onChanged: _isEditing ? (String? newValue) {
        setState(() {
          _selectedBloodGroup = newValue;
        });
      } : null,
      validator: (value) => value == null ? 'Please select blood group' : null,
    );
  }

  /// Builds action buttons
  Widget _buildActionButtons() {
    return Column(
      children: [
        // Save button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            onPressed: _isLoading ? null : _saveProfile,
            child: _isLoading
                ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              ),
            )
                : const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.save_rounded, size: 20),
                SizedBox(width: 8),
                Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Cancel button
        SizedBox(
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            onPressed: _cancelEditing,
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Event Handlers and Utility Methods

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _handleBackPress(BuildContext context) {
    if (_isEditing) {
      _showUnsavedChangesDialog(context);
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _showImagePickerDialog() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Update Profile Picture',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _textColor,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageSourceOption(
                  icon: Icons.camera_alt_rounded,
                  label: 'Camera',
                  onTap: () => _pickImage(ImageSource.camera),
                ),
                _buildImageSourceOption(
                  icon: Icons.photo_library_rounded,
                  label: 'Gallery',
                  onTap: () => _pickImage(ImageSource.gallery),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _lightGreen.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: _primaryGreen, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: _primaryGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    Navigator.pop(context); // Close bottom sheet
    final picker = ImagePicker();
    try {
      final picked = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (picked != null) {
        setState(() {
          _profileImage = File(picked.path);
        });
      }
    } catch (e) {
      _showErrorSnackBar('Failed to pick image: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: _primaryGreen),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _controllers['dob']!.text =
        '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';

        // Calculate age
        final age = DateTime.now().year - picked.year;
        _controllers['age']!.text = age.toString();
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Implement actual save logic
      // await UserProfileService.saveProfile({
      //   'name': _controllers['name']!.text,
      //   'email': _controllers['email']!.text,
      //   // ... other fields
      // });

      setState(() {
        _isEditing = false;
        _isLoading = false;
      });

      _showSuccessSnackBar('Profile saved successfully!');
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar('Failed to save profile: $e');
    }
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
    });
    // TODO: Reload original data if needed
    _loadUserData();
  }

  void _showUnsavedChangesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Unsaved Changes'),
        content: const Text('You have unsaved changes. Are you sure you want to leave?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Stay'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back
            },
            child: const Text('Leave', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: _primaryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
