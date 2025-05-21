import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 6 && hour <= 11) {
      return 'Selamat pagi, ';
    } else if (hour >= 12 && hour <= 15) {
      return 'Selamat siang, ';
    } else if (hour >= 16 && hour <= 17) {
      return 'Selamat sore, ';
    } else {
      return 'Selamat malam, ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 70.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                          text: getGreeting(),
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                            text: 'Hitam',
                            style: GoogleFonts.poppins(
                              color: Color.fromRGBO(105, 153, 77, 1),
                              fontSize: 15,
                            )),
                      ],
                    )),
                    Text(
                      'Yuk mulai jaga lingkungan kamu!',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromRGBO(22, 76, 62, 1),
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/editProfile');
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 20,
                        child: Icon(Icons.person),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: AssetImage('assets/images/container_dash.jpg'),
                    fit: BoxFit.cover),
              ),
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                margin: EdgeInsets.only(top: 20),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.07, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Poin Kamu',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(44, 66, 20, 1),
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/coin.svg',
                          ),
                          SizedBox(width: 6),
                          Text(
                            '200',
                            style: TextStyle(
                                color: Color.fromRGBO(255, 219, 89, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 1,
                        color: Colors.black,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Total Sampah',
                        style: TextStyle(
                            color: Color.fromRGBO(44, 66, 20, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/recycle-bottle.svg',
                          ),
                          SizedBox(width: 6),
                          Text(
                            '400000',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Status Kamu',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Subtitle
                      Text(
                        'Aktivitas Bulanan',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[800],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'April 2025',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Legend
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildLegendItem(Color(0xFF4CAF50), 'Recycle'),
                          SizedBox(width: 16),
                          _buildLegendItem(Color(0xFFFFC107), 'Non-recycle'),
                          SizedBox(width: 16),
                          _buildLegendItem(Color(0xFFF44336), 'B3'),
                        ],
                      ),
                      SizedBox(height: 24),

                      // Bar Chart
                      AspectRatio(
                        aspectRatio: 1.7,
                        child: BarChart(
                          BarChartData(
                            barGroups: _createBarGroups(),
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget:
                                      (double value, TitleMeta meta) {
                                    const style = TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    );
                                    switch (value.toInt()) {
                                      case 0:
                                        return Text('Minggu 1', style: style);
                                      case 1:
                                        return Text('Minggu 2', style: style);
                                      case 2:
                                        return Text('Minggu 3', style: style);
                                      case 3:
                                        return Text('Minggu 4', style: style);
                                      default:
                                        return Text('', style: style);
                                    }
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            barTouchData: BarTouchData(enabled: false),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kategori Limbah',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Lihat Selengkapnya',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                const SizedBox(height: 16),
                // Category Items
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    WasteCategoryItem(
                      icon: Icons.shopping_bag,
                      label: 'Recycle',
                    ),
                    WasteCategoryItem(
                      icon: Icons.set_meal, // contoh icon untuk Non-Recycle
                      label: 'Non-Recycle',
                    ),
                    WasteCategoryItem(
                      icon: Icons.battery_full,
                      label: 'Limbah B3',
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(fontSize: 13),
        ),
      ],
    );
  }

  List<BarChartGroupData> _createBarGroups() {
    return [
      _makeGroup(0, 3, 5, 7),
      _makeGroup(1, 8, 2, 5),
      _makeGroup(2, 7, 9, 6),
      _makeGroup(3, 4, 2, 7),
    ];
  }

  BarChartGroupData _makeGroup(
      int x, double recycle, double nonRecycle, double b3) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: recycle,
          width: 12,
          color: Color(0xFF4CAF50),
          borderRadius: BorderRadius.circular(6),
        ),
        BarChartRodData(
          toY: nonRecycle,
          width: 12,
          color: Color(0xFFFFC107),
          borderRadius: BorderRadius.circular(6),
        ),
        BarChartRodData(
          toY: b3,
          width: 12,
          color: Color(0xFFF44336),
          borderRadius: BorderRadius.circular(6),
        ),
      ],
      barsSpace: 6,
    );
  }
}

class WasteCategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const WasteCategoryItem({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFF2D5F4D),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D5F4D),
          ),
        ),
      ],
    );
  }
}
