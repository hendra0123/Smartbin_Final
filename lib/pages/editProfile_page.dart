import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smartbin/controller/userProfile_provider.dart';

class EditprofilePage extends StatefulWidget {
  const EditprofilePage({super.key});

  @override
  State<EditprofilePage> createState() => _EditprofilePageState();
}

class _EditprofilePageState extends State<EditprofilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  File? _imageFile;

  @override
  void initState() {
    super.initState();
    final profileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);

    _nameController.text = profileProvider.fullName;

    _usernameController.text = "username";
    _phoneController.text = "";
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    final profileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);

    if (_nameController.text.isNotEmpty &&
        _nameController.text != profileProvider.fullName) {
      profileProvider.updateName(_nameController.text);
    }

    if (_imageFile != null) {
      profileProvider.updateProfileImage(_imageFile!);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil berhasil diperbarui!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<UserProfileProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF164C3E),
                  Color(0xFF69994D),
                ],
              ),
            ),
          ),

          // Body content
          Column(
            children: [
              const SizedBox(height: 230), // Sesuaikan dengan posisi avatar
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                            height: 90), // Space untuk avatar yang overlap
                        const Text(
                          'Full Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller:
                              _nameController, // Controller sudah diinisialisasi di initState
                          decoration: InputDecoration(
                            // hintText: 'Name', // Dihilangkan karena controller sudah mengisi
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Username',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            // hintText: 'Your Username',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            prefixIcon: Icon(
                                Icons.account_circle), // Icon yang lebih sesuai
                          ),
                          // Ingat: Perubahan username belum disimpan tanpa update di UserProfileProvider
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          // Untuk email, kita tampilkan dari provider jika ada, dan set readOnly
                          // Anda perlu menambahkan getter 'email' di UserProfileProvider
                          // contoh: hintText: profileProvider.email ?? 'Email Address',
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText:
                                'email@example.com', // Ganti dengan profileProvider.email jika ada
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Phone Number',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            // hintText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            prefixIcon: Icon(Icons.phone),
                          ),
                          // Ingat: Perubahan nomor telepon belum disimpan tanpa update di UserProfileProvider
                        ),
                        const SizedBox(height: 60),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                _saveProfile, // Panggil method _saveProfile
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF164C3E),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Profile photo & camera icon
          Positioned(
            top: 140,
            left: MediaQuery.of(context).size.width / 2 - 90,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : (profileProvider.profileImage != null &&
                              profileProvider.profileImage!.path.isNotEmpty
                          ? FileImage(profileProvider.profileImage!)
                          : const AssetImage('assets/images/profile.jpg')
                              as ImageProvider),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 24,
                        color: Color(0xFF164C3E),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
