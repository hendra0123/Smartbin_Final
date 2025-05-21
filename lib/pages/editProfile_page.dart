import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 260),
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
                        const SizedBox(height: 40),
                        _buildInputField(
                            label: 'Full Name',
                            icon: Icons.person,
                            hint: 'Name'),
                        _buildInputField(
                            label: 'Username',
                            icon: Icons.edit,
                            hint: 'Your Username'),
                        _buildInputField(
                            label: 'Email',
                            icon: Icons.email,
                            hint: 'Email Address'),
                        _buildInputField(
                            label: 'Phone Number',
                            icon: Icons.phone,
                            hint: 'Phone Number'),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
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
                        SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'Point History',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: const [
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
                          ],
                        ),
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
              children: [
                const CircleAvatar(
                  radius: 90,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                ),
                Positioned(
                  bottom: 120,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(Icons.camera_alt, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reusable input field builder
  Widget _buildInputField(
      {required String label, required IconData icon, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            prefixIcon: Icon(icon),
          ),
        ),
        const SizedBox(height: 20),
      ],
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
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
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
    );
  }
}
