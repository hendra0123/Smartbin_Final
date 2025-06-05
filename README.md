# smartbin

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

# 📦 SmartBin Unit Tests

Folder ini berisi unit test untuk aplikasi Flutter *SmartBin*. Tujuan pengujian adalah untuk memastikan setiap halaman, logika controller, dan fungsi utilitas berjalan dengan benar dan sesuai dengan spesifikasi.

---

## 🧪 Struktur Pengujian

|  Folder          | Penjelasan                                                     |
|------------------|----------------------------------------------------------------|
|  `pages/`        | Berisi test untuk halaman UI (Widget Test)                     |
|  `utils/`        | Berisi test untuk fungsi logika dan validator                  |
|  `controllers/`  | Berisi Test untuk controller (logika, state, kuis, dsb) |
---

## 🛠️ Menjalankan Tes

Untuk menjalankan seluruh pengujian, jalankan perintah berikut di root project:

```bash
flutter test
```

Untuk menjalankan pengujian tertentu:

```bash
flutter test test/pages/phone_number_page_test.dart
flutter test test/pages/form_exchange_test.dart
flutter test test/utils/exchange_validator_test.dart
```