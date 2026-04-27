import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Data profil
  String name = 'Jhon Doe';
  String bio = 'Mahasiswa Sistem Informasi yang memiliki minat dan fokus dalam bidang Mobile Programming.'
  'Memiliki kemampuan dalam pengembangan aplikasi mobile menggunakan Flutter serta memahami dasar-dasar UI/UX, integrasi API, dan manajemen data.'
  'Aktif belajar dan mengembangkan proyek aplikasi untuk meningkatkan keterampilan teknis.';
  String location = 'Jakarta, Indonesia';
  String email = 'jhon.doe@example.com';
  String phone = '+62 123-4567-2292';
  String birthday = 'March 15, 2000';
  String occupation = 'Mobile Programmer at Universitas Pamulang';
  
  // Support both network URL and local file
  String? avatarUrl;
  File? avatarFile;
  
  //Data Skills
  List<String> skills = ['Flutter', 'UI/UX Design', 'Laravel', 'Figma', 'SQL'];
  Map<String, Color> skillColors = {
    'Flutter': Colors.blue,
    'UI/UX Design': Colors.purple,
    'Laravel': Colors.deepOrangeAccent,
    'Figma': Colors.pink,
    'SQL': Colors.green,
  };

  void _updateProfile(Map<String, dynamic> updatedData) {
    setState(() {
      if (updatedData['name'] != null) name = updatedData['name'];
      if (updatedData['bio'] != null) bio = updatedData['bio'];
      if (updatedData['location'] != null) location = updatedData['location'];
      if (updatedData['email'] != null) email = updatedData['email'];
      if (updatedData['phone'] != null) phone = updatedData['phone'];
      if (updatedData['birthday'] != null) birthday = updatedData['birthday'];
      if (updatedData['occupation'] != null) occupation = updatedData['occupation'];
      if (updatedData['avatarUrl'] != null) avatarUrl = updatedData['avatarUrl'];
      if (updatedData['avatarFile'] != null) avatarFile = updatedData['avatarFile'];
      if (updatedData['skills'] != null) skills = updatedData['skills'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //Cover Header
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF667EEA),
                      Color(0xFF764BA2),
                    ],
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Opacity(
                      opacity: 0.9,
                      child: Image.network(
                        'https://images.unsplash.com/photo-1532274402911-5a369e4c4bb5?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Hero(
                          tag: 'avatar',
                          child: GestureDetector(
                            onTap: () => _openEditProfileSheet(),
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: _getAvatarImage(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                location,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildStatCard('Posts', '248', Icons.photo_library),
                        _buildStatCard('Followers', '12.5K', Icons.people),
                        _buildStatCard('Following', '894', Icons.person_add),
                      ],
                    ),
                    const SizedBox(height: 32),
                    
                    const Text(
                      'About Me',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: Text(
                        bio,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: Color(0xFF4A5568),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    const Text(
                      'Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(Icons.email, email),
                    _buildInfoRow(Icons.phone, phone),
                    _buildInfoRow(Icons.cake, birthday),
                    _buildInfoRow(Icons.work, occupation),
                    const SizedBox(height: 32),
                    
                    const Text(
                      'Skills & Interests',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: skills.map((skill) {
                        return _buildSkillChip(
                          skill, 
                          skillColors[skill] ?? Colors.grey
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                    
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _openEditProfileSheet(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF667EEA),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profile shared!'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF667EEA),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: const BorderSide(
                                color: Color(0xFF667EEA),
                                width: 2,
                              ),
                            ),
                            child: const Text(
                              'Share Profile',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider _getAvatarImage() {
    if (avatarFile != null) {
      return FileImage(avatarFile!);
    } else if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return NetworkImage(avatarUrl!);
    } else {
      return const NetworkImage('https://images.unsplash.com/photo-1452570053594-1b985d6ea890?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
    }
  }

  void _openEditProfileSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditProfileSheet(
        currentData: {
          'name': name,
          'bio': bio,
          'location': location,
          'email': email,
          'phone': phone,
          'birthday': birthday,
          'occupation': occupation,
          'avatarUrl': avatarUrl,
          'avatarFile': avatarFile,
          'skills': skills,
        },
        onSave: _updateProfile,
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.shade50,
              Colors.grey.shade100,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF667EEA), size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF667EEA).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF667EEA),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF4A5568),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
    );
  }
}

// ==================== EDIT PROFILE SHEET ====================

class EditProfileSheet extends StatefulWidget {
  final Map<String, dynamic> currentData;
  final Function(Map<String, dynamic>) onSave;

  const EditProfileSheet({
    super.key,
    required this.currentData,
    required this.onSave,
  });

  @override
  State<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {
  late TextEditingController nameController;
  late TextEditingController bioController;
  late TextEditingController locationController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController birthdayController;
  late TextEditingController occupationController;
  late TextEditingController avatarUrlController;
  late List<String> skills;
  late TextEditingController newSkillController;
  
  File? avatarFile;
  String? avatarUrl;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentData['name']);
    bioController = TextEditingController(text: widget.currentData['bio']);
    locationController = TextEditingController(text: widget.currentData['location']);
    emailController = TextEditingController(text: widget.currentData['email']);
    phoneController = TextEditingController(text: widget.currentData['phone']);
    birthdayController = TextEditingController(text: widget.currentData['birthday']);
    occupationController = TextEditingController(text: widget.currentData['occupation']);
    avatarUrlController = TextEditingController(text: widget.currentData['avatarUrl'] ?? '');
    avatarFile = widget.currentData['avatarFile'];
    avatarUrl = widget.currentData['avatarUrl'];
    skills = List<String>.from(widget.currentData['skills']);
    newSkillController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    locationController.dispose();
    emailController.dispose();
    phoneController.dispose();
    birthdayController.dispose();
    occupationController.dispose();
    avatarUrlController.dispose();
    newSkillController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      
      if (pickedFile != null) {
        setState(() {
          avatarFile = File(pickedFile.path);
          avatarUrl = null; // Clear URL when using local file
          avatarUrlController.clear(); // Clear URL text field
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

  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Change Avatar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF667EEA)),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF667EEA)),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.link, color: Color(0xFF667EEA)),
                title: const Text('Use URL'),
                onTap: () {
                  Navigator.pop(context);
                  _showUrlDialog();
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _showUrlDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController urlController = TextEditingController(text: avatarUrlController.text);
        return AlertDialog(
          title: const Text('Enter Image URL'),
          content: TextField(
            controller: urlController,
            decoration: const InputDecoration(
              hintText: 'https://example.com/image.jpg',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.url,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (urlController.text.trim().isNotEmpty) {
                  setState(() {
                    avatarUrl = urlController.text.trim();
                    avatarFile = null;
                    avatarUrlController.text = avatarUrl!;
                  });
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF667EEA),
              ),
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  void _addSkill() {
    if (newSkillController.text.trim().isNotEmpty) {
      setState(() {
        skills.add(newSkillController.text.trim());
        newSkillController.clear();
      });
    }
  }

  void _removeSkill(int index) {
    setState(() {
      skills.removeAt(index);
    });
  }

  void _saveChanges() {
    final updatedData = {
      'name': nameController.text,
      'bio': bioController.text,
      'location': locationController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'birthday': birthdayController.text,
      'occupation': occupationController.text,
      'avatarUrl': avatarUrl,
      'avatarFile': avatarFile,
      'skills': skills,
    };
    widget.onSave(updatedData);
    Navigator.pop(context);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: _saveChanges,
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar Section with Change Button
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF667EEA),
                                  width: 3,
                                ),
                                image: DecorationImage(
                                  image: _getAvatarPreview(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _showImagePickerDialog,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF667EEA),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _showImagePickerDialog,
                          child: const Text(
                            'Change Avatar',
                            style: TextStyle(
                              color: Color(0xFF667EEA),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Optional: Show URL field if using URL
                  if (avatarUrl != null && avatarFile == null) ...[
                    _buildTextField(avatarUrlController, 'Avatar URL', Icons.link),
                    const SizedBox(height: 16),
                  ],
                  
                  // Form Fields
                  _buildTextField(nameController, 'Full Name', Icons.person),
                  const SizedBox(height: 16),
                  _buildTextField(locationController, 'Location', Icons.location_on),
                  const SizedBox(height: 16),
                  _buildTextField(emailController, 'Email', Icons.email, 
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 16),
                  _buildTextField(phoneController, 'Phone', Icons.phone,
                      keyboardType: TextInputType.phone),
                  const SizedBox(height: 16),
                  _buildTextField(birthdayController, 'Birthday', Icons.cake),
                  const SizedBox(height: 16),
                  _buildTextField(occupationController, 'Occupation', Icons.work),
                  const SizedBox(height: 16),
                  _buildTextField(bioController, 'Bio', Icons.description,
                      maxLines: 4),
                  const SizedBox(height: 24),
                  
                  // Skills Section
                  const Text(
                    'Skills',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: skills.asMap().entries.map((entry) {
                      int index = entry.key;
                      String skill = entry.value;
                      return Chip(
                        label: Text(skill),
                        backgroundColor: Colors.grey.shade100,
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () => _removeSkill(index),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: newSkillController,
                          decoration: InputDecoration(
                            hintText: 'Add new skill',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          onSubmitted: (_) => _addSkill(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: _addSkill,
                        icon: const Icon(Icons.add_circle),
                        color: const Color(0xFF667EEA),
                        iconSize: 40,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Avatar Image
  ImageProvider _getAvatarPreview() {
    if (avatarFile != null) {
      return FileImage(avatarFile!);
    } else if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return NetworkImage(avatarUrl!);
    } else {
      return const NetworkImage('https://images.unsplash.com/photo-1452570053594-1b985d6ea890?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
    }
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4A5568),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF667EEA)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF667EEA), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}