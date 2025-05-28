import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartbin/controller/userProfile_provider.dart';
import 'package:smartbin/pages/editProfile_page.dart';

class ProfilePage extends StatelessWidget {
  final String imagePath;
  const ProfilePage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<UserProfileProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Background hijau gradient separuh layar dari atas
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF164C3E),
                          Color(0xFF69994D),
                        ],
                      ),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                  ),
                ),

                // Card profil mengambang
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(22),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  profileProvider.profileImage != null
                                      ? FileImage(profileProvider.profileImage!)
                                      : const AssetImage(
                                              'assets/images/profile.jpg')
                                          as ImageProvider,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Hi, There!",
                                    style: TextStyle(
                                      color: Colors.green[700],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    profileProvider.fullName,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const EditprofilePage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Edit profile",
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Riwayat Poin
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.22,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(height: 20),
                          Text(
                            'Point History',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 12),
                          PointHistoryItem(
                            title: 'Daur ulang botol plastik',
                            date: '2025-05-12',
                            points: 20,
                          ),
                          PointHistoryItem(
                            title: 'Sampah salah tempat',
                            date: '2025-05-10',
                            points: -10,
                          ),
                          PointHistoryItem(
                            title: 'Daur ulang kardus',
                            date: '2025-05-08',
                            points: 15,
                          ),
                          SizedBox(height: 20),
                        ],
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

// Riwayat Poin Widget
class PointHistoryItem extends StatelessWidget {
  final String title;
  final String date;
  final int points;

  const PointHistoryItem({
    super.key,
    required this.title,
    required this.date,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(
          points > 0 ? Icons.add_circle : Icons.remove_circle,
          color: points > 0 ? Colors.green : Colors.red,
        ),
        title: Text(title),
        subtitle: Text(date),
        trailing: Text(
          '${points > 0 ? '+' : ''}$points pts',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: points > 0 ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}
