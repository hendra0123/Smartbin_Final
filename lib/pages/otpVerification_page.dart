import 'package:flutter/material.dart';
import 'package:smartbin/main.dart';
import 'dart:async'; // Untuk Timer

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationPage({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Timer? _timer;
  int _start = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _otpFocusNodes.isNotEmpty) {
        // Tambahkan pengecekan mounted
        FocusScope.of(context).requestFocus(_otpFocusNodes[0]);
      }
    });
  }

  void _startTimer() {
    setState(() {
      _canResend = false;
      _start = 60;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        // Hentikan timer jika widget sudah tidak ada di tree
        timer.cancel();
        return;
      }
      if (_start == 0) {
        setState(() {
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _resendOtp() {
    // TODO: Implementasi logika kirim ulang OTP ke widget.phoneNumber
    print('Kirim ulang OTP ke ${widget.phoneNumber}');
    _startTimer();
    for (var controller in _otpControllers) {
      controller.clear();
    }
    if (mounted && _otpFocusNodes.isNotEmpty) {
      FocusScope.of(context).requestFocus(_otpFocusNodes[0]);
    }
  }

  void _verifyOtp() {
    if (_formKey.currentState!.validate()) {
      String otp = _otpControllers.map((controller) => controller.text).join();
      // TODO: Implementasi logika verifikasi OTP dengan backend/Firebase Auth
      print('OTP dimasukkan: $otp untuk nomor ${widget.phoneNumber}');

      if (otp == "123456") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verifikasi OTP Berhasil!')),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
          (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kode OTP salah!')),
        );
        for (var controller in _otpControllers) {
          controller.clear();
        }
        if (mounted && _otpFocusNodes.isNotEmpty) {
          FocusScope.of(context).requestFocus(_otpFocusNodes[0]);
        }
      }
    } else {
      // Jika validasi form gagal (ada field OTP yang kosong)
      // Anda bisa menampilkan pesan atau menandai field yang kosong jika diinginkan
      // Untuk saat ini, tidak ada aksi khusus karena validator per field hanya mengembalikan string kosong
      // Fokus akan tetap pada field yang belum diisi atau field pertama.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi semua kolom OTP.')),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildOtpTextField(int index) {
    return SizedBox(
      width:
          45, // Lebar bisa disesuaikan atau dibungkus Expanded jika di dalam Row yang fleksibel
      height: 50,
      child: TextFormField(
        controller: _otpControllers[index],
        focusNode: _otpFocusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                color: Color.fromRGBO(105, 153, 77, 1), width: 2),
          ),
          contentPadding: EdgeInsets
              .zero, // Untuk memastikan teks terpusat jika tinggi disesuaikan
        ),
        onChanged: (value) {
          if (value.length == 1 && index < _otpControllers.length - 1) {
            FocusScope.of(context).requestFocus(_otpFocusNodes[index + 1]);
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(_otpFocusNodes[index - 1]);
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            // Tidak menampilkan pesan error individu untuk menjaga UI tetap bersih,
            // validasi utama ada di tombol "Verifikasi"
            return '';
          }
          return null;
        },
        // Tambahkan style untuk ukuran font jika diperlukan agar pas
        // style: TextStyle(fontSize: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Untuk membuat field OTP lebih responsif terhadap lebar layar
    double screenWidth = MediaQuery.of(context).size.width;
    double otpFieldWidth =
        (screenWidth - (24 * 2) - (10 * (_otpControllers.length - 1))) /
            _otpControllers.length;
    // 24*2 untuk padding horizontal halaman, 10 untuk spasi antar field OTP
    // Sesuaikan angka 10 ini jika Anda mengubah spasi di Row/Wrap field OTP

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Verifikasi OTP',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        // Bungkus dengan SingleChildScrollView agar konten bisa di-scroll jika keyboard muncul atau layar kecil
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Masukkan 6 digit kode OTP yang dikirimkan ke nomor:',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.phoneNumber,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Gunakan Wrap untuk field OTP agar responsif
                Wrap(
                  alignment: WrapAlignment.center, // Pusatkan field OTP
                  spacing: 10, // Spasi horizontal antar field OTP
                  runSpacing:
                      10, // Spasi vertikal jika ada baris baru (tidak akan terjadi dengan 6 field)
                  children: List.generate(_otpControllers.length, (index) {
                    // Menggunakan SizedBox untuk mengontrol lebar field OTP secara dinamis
                    // atau gunakan lebar tetap jika lebih disukai dari _buildOtpTextField
                    return SizedBox(
                        width: otpFieldWidth > 45
                            ? 45
                            : otpFieldWidth, // Batasi lebar maksimum atau gunakan hasil perhitungan
                        // width: 45, // Atau lebar tetap seperti sebelumnya jika itu preferensi Anda
                        child: _buildOtpTextField(index));
                  }),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(105, 153, 77, 1),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Verifikasi",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),
                // Gunakan Wrap untuk bagian "Tidak menerima kode?" dan "Kirim ulang"
                Wrap(
                  alignment: WrapAlignment.center, // Pusatkan teks
                  crossAxisAlignment: WrapCrossAlignment
                      .center, // Sejajarkan item secara vertikal di tengah
                  spacing: 4.0, // Spasi horizontal kecil antar teks
                  runSpacing: 0.0, // Spasi jika ada baris baru
                  children: [
                    const Text("Tidak menerima kode?",
                        style:
                            TextStyle(fontSize: 14)), // Sedikit perkecil font
                    TextButton(
                      onPressed: _canResend ? _resendOtp : null,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 0), // Kurangi padding
                        minimumSize:
                            Size.zero, // Untuk memperkecil area tap jika perlu
                        tapTargetSize: MaterialTapTargetSize
                            .shrinkWrap, // Untuk memperkecil area tap
                      ),
                      child: Text(
                        _canResend
                            ? "Kirim ulang"
                            : "Kirim ulang dalam $_start dtk", // "detik" jadi "dtk"
                        style: TextStyle(
                          color: _canResend
                              ? const Color.fromRGBO(105, 153, 77, 1)
                              : Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 14, // Sedikit perkecil font
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Tambahan spasi di bawah
              ],
            ),
          ),
        ),
      ),
    );
  }
}
