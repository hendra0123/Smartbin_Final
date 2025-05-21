// kategori_items.dart

class KategoriItem {
  final String name;
  final String imageAsset;
  final String description;

  KategoriItem(
      {required this.name,
      required this.imageAsset,
      required this.description});
}

final List<KategoriItem> recycleItems = [
  KategoriItem(
      name: "Botol Plastik",
      imageAsset: "assets/images/recycle.jpg",
      description: "Dapat didaur ulang menjadi bahan baru."),
  KategoriItem(
      name: "Kertas Bekas",
      imageAsset: "assets/images/box.jpg",
      description: "Dapat diproses menjadi kertas baru."),
];

final List<KategoriItem> nonRecycleItems = [
  KategoriItem(
      name: "Styrofoam",
      imageAsset: "assets/images/nonrecycle.jpg",
      description: "Tidak bisa diurai atau didaur ulang."),
  KategoriItem(
      name: "Tisu Bekas",
      imageAsset: "assets/images/b3.jpeg",
      description: "Cepat rusak dan sulit diproses kembali."),
];

final List<KategoriItem> b3Items = [
  KategoriItem(
      name: "Baterai Bekas",
      imageAsset: "assets/images/voucher.jpg",
      description: "Mengandung bahan kimia berbahaya."),
  KategoriItem(
      name: "Obat Kedaluwarsa",
      imageAsset: "assets/images/video_thumb1.jpg",
      description: "Dapat mencemari lingkungan."),
];
