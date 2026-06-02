import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  // Ensure status bar style is clean
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DewaFish Explore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF075E94),
          surface: const Color(0xFFF7F9FC),
        ),
        textTheme: GoogleFonts.montserratTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF0A3C5F)),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => MainNavigationScreenState();
}

class MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  Key _quizKey = UniqueKey();

  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        _quizKey = UniqueKey();
      }
    });
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const MaterialScreen();
      case 2:
        return QuizScreen(key: _quizKey);
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x0A000000), // 4% opacity black
              blurRadius: 10,
              offset: Offset(0, -4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home, 'Home'),
              _buildNavItem(1, Icons.menu_book_outlined, 'Material'),
              _buildNavItem(2, Icons.quiz_outlined, 'Quiz'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => changeTab(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFB5ECD0) : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF145238)
                  : const Color(0xFF555555),
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected
                  ? const Color(0xFF145238)
                  : const Color(0xFF555555),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'DewaFish Explore',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 22,
              color: Color(0xFF0E5482),
              letterSpacing: -0.5,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Container
            Container(
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1F000000), // 12% opacity black
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  // Background Image
                  AspectRatio(
                    aspectRatio:
                        0.65, // Tall aspect ratio to fit all content nicely
                    child: Image.asset(
                      'assets/images/background.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Dark Overlay Gradient for readability
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x33000000), // 20% opacity black
                            Color(0x66000000), // 40% opacity black
                            Color(0xD9000000), // 85% opacity black
                          ],
                          stops: [0.0, 0.4, 0.9],
                        ),
                      ),
                    ),
                  ),
                  // Banner Content
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 28,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top text
                          const Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'BULAN WATER PARADISE',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'KUNIGAN, INDONESIA - DISCOVER NATURAL WONDERS',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          // Habitat Suci Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0x8081C784,
                              ), // 50% opacity green
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(
                                  0x4D81C784,
                                ), // 30% opacity green
                                width: 1,
                              ),
                            ),
                            child: const Text(
                              'Habitat Suci',
                              style: TextStyle(
                                color: Color(0xFFE8F5E9),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Discover the Legend title
                          const Text(
                            'Discover the\nLegend of Ikan\nDewa',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Subtitle paragraph
                          const Text(
                            'Benamkan dirimu dalam ketenangan perairan Kuningan. Jelajahi keajaiban ekologi dan warisan budaya dari Ikan Dewa yang sakral di habitat alaminya.',
                            style: TextStyle(
                              color: Color(0xE6FFFFFF), // 90% opacity white
                              fontSize: 13.5,
                              height: 1.45,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Start Explore Button
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {
                                // Dynamic interaction to open Material screen
                                final mainNav = context
                                    .findAncestorStateOfType<
                                      MainNavigationScreenState
                                    >();
                                if (mainNav != null) {
                                  mainNav.changeTab(1);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF075E94),
                                foregroundColor: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Start Explore',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.explore, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Oasis Card Container
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x08000000), // 3% opacity black
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Droplet Badge
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD4E7F5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.water_drop_outlined,
                      color: Color(0xFF075E94),
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Title
                  const Text(
                    'Oasis Sang Ikan Dewa',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1D1D1D),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Body text
                  const Text(
                    '“Ikan Dewa” atau Tor soro adalah spesies ikan legendaris yang ditemukan di kolam alami Cibulan, Cigugur, dan Darma, Kuningan. Dikenal karena sifatnya yang jinak dan statusnya yang sakral, ikan ini hidup berdampingan secara harmonis dengan para pengunjung di perairan jernih yang dialiri mata air pegunungan alami.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5A5A5A),
                      height: 1.55,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// PREMIUM MATERIAL SCREEN FOR INTERACTIVE TAB
class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  int? _selectedMaterialIndex;

  final List<Map<String, dynamic>> materials = [
    {
      'title': 'Sejarah Ikan Dewa',
      'detailTitle': 'Sejarah & Legenda Ikan Dewa',
      'desc': 'Pelajari asal-usul dan sejarah panjang keberadaan Ikan Dewa di tanah Kuningan',
      'image': 'assets/images/sejarah_ikan_dewa.jpg',
      'icon': Icons.history_edu_rounded,
      'iconColor': const Color(0xFF2B5C8F),
      'actionText': 'Baca Selengkapnya',
      'actionColor': const Color(0xFF075E94),
      'badges': [
        {'text': 'Budaya', 'bg': const Color(0xFFE8F5E9), 'fg': const Color(0xFF2E7D32)},
        {'text': 'Edukasi', 'bg': const Color(0xFFE3F2FD), 'fg': const Color(0xFF1565C0)},
      ],
'paragraphs': [
        'Ikan Dewa, atau yang dikenal dengan nama ilmiah Tor douronensis, merupakan spesies ikan air tawar yang memiliki nilai sejarah dan budaya yang sangat kental bagi masyarakat Kuningan, Jawa Barat. Keberadaan ikan ini tidak hanya sekadar bagian dari ekosistem perairan, melainkan telah menjadi simbol sakral yang dijaga kelestariannya secara turun-temurun.',
        'Menurut legenda lokal yang berkembang di masyarakat, Ikan Dewa diyakini sebagai jelmaan dari prajurit-prajurit Prabu Siliwangi, seorang raja agung dari Kerajaan Pajajaran yang termasyhur. Cerita turun-temurun menyebutkan bahwa para prajurit tersebut dikutuk menjadi ikan karena membangkang atau tidak setia terhadap sumpah mereka. Mitos ini tumbuh subur dan menjadi pelindung tak kasat mata bagi habitat ikan-ikan ini, mencegah masyarakat sekitar untuk memburu atau mengonsumsinya.',
        'Saat ini, Ikan Dewa menjadi daya tarik utama wisata edukasi dan alam di Kuningan. Habitat mereka, seperti di pemandian Cibulan, dijaga ketat kebersihannya. Wisatawan yang datang tidak hanya disuguhkan pemandangan air yang sejernih kristal, tetapi juga kesempatan untuk berinteraksi langsung dengan ikan-ikan raksasa yang jinak ini, sambil mempelajari nilai-nilai kearifan lokal dalam menjaga keseimbangan alam.'
      ]
    },
    {
      'title': 'Mitos & Kepercayaan',
      'detailTitle': 'Mitos & Kepercayaan',
      'desc': 'Kumpulan cerita rakyat, pantangan, dan kepercayaan masyarakat lokal yang...',
      'image': 'assets/images/mitos_kepercayaan.png',
      'icon': Icons.auto_awesome_rounded,
      'iconColor': const Color(0xFF0E7055),
      'actionText': 'Baca Selengkapnya',
      'actionColor': const Color(0xFF075E94),
      'badges': [
        {'text': 'Budaya', 'bg': const Color(0xFFD1F2D9), 'fg': const Color(0xFF145238)},
        {'text': 'Edukasi', 'bg': const Color(0xFF075E94), 'fg': Colors.white},
      ],
      'paragraphs': [
        'Mitos yang paling populer adalah bahwa ikan dewa merupakan jelmaan prajurit Prabu Siliwangi yang membangkang dan tidak setia. Karena pengkhianatannya, Prabu Siliwangi mengutuk para prajurit tersebut menjadi ikan. Konon, prajurit-prajurit yang tidak setia itu kabur ke sebuah tempat pemandian di daerah Kuningan, dan di situlah mereka dikutuk. Kepercayaan serupa juga berlaku bagi prajurit yang lari ke darat  mereka dipercaya berubah menjadi harimau.',
        'Versi lain menyebutkan asal-usul yang berbeda. Menurut situs resmi Disporapar Kabupaten Kuningan, ikan dewa konon dibawa oleh para murid Wali Songo saat mereka datang ke Cibulan. Para murid itu pun meninggalkan tujuh buah sumur yang digunakan untuk berwudhu, yang hingga kini dianggap keramat.',
        {
          'type': 'heading',
          'text': 'Mitos-Mitos Utama'
        },
        {
          'type': 'list_item',
          'number': '1. ',
          'title': 'Jumlah Tidak Pernah Berubah ',
          'desc': 'Konon dari dulu hingga sekarang, jumlah ikan dewa di Cibulan tidak pernah berkurang maupun bertambah. Padahal ikan-ikan tersebut tetap berkembang biak seperti ikan pada umumnya, namun kolam tidak pernah terlihat penuh.'
        },
        {
          'type': 'list_item',
          'number': '2. ',
          'title': 'Pantang Dibunuh atau Dimakan ',
          'desc': 'Ada cerita bahwa seseorang pernah membawa ikan dewa pulang lalu memasaknya. Setelah memakannya, orang tersebut jatuh sakit dan meninggal dunia. Kepercayaan ini membuat warga setempat tidak berani mengambil, membunuh, apalagi memakan ikan ini.'
        },
        {
          'type': 'list_item',
          'number': '3. ',
          'title': 'Ritual Penguburan Layaknya Manusia ',
          'desc': 'Saat ditemukan ikan dewa yang mati, warga memperlakukannya secara khusus  ikan tersebut dikubur dengan kain kafan layaknya jenazah manusia. Keunikan lain, ikan yang mati tidak terapung ke permukaan, melainkan tetap berada di dasar kolam, meski tetap mengeluarkan bau amis.'
        },
        {
          'type': 'list_item',
          'number': '4. ',
          'title': 'Menghilang saat Hendak Dibudidayakan ',
          'desc': 'Pernah suatu ketika pihak Dinas Perikanan datang untuk meninjau dan akan membudidayakan ikan-ikan dewa. Siang harinya semua ikan terlihat, namun ketika malam hari dicek kembali, tidak ada satu pun ikan yang terlihat semuanya menghilang.'
        },
        {
          'type': 'list_item',
          'number': '5. ',
          'title': 'Mendatangkan Kesialan bagi yang Mengganggunya ',
          'desc': 'Mitos yang berkembang menyebutkan bahwa siapa pun yang merusak kolam atau mengganggu ikan-ikan ini akan mengalami kesialan.'
        }
      ]
    },
    {
      'title': 'Fakta Unik',
      'detailTitle': 'Fakta Unik Ikan Dewa',
      'desc': 'Karakteristik biologis, perilaku, dan habitat spesifik yang membuat ikan ini...',
      'image': 'assets/images/fakta_unik.jpg',
      'icon': Icons.push_pin_rounded,
      'iconColor': const Color(0xFF075E94),
      'actionText': 'Baca Selengkapnya',
      'actionColor': const Color(0xFF075E94),
      'badges': [
        {'text': 'Budaya', 'bg': const Color(0xFFD1F2D9), 'fg': const Color(0xFF145238)},
        {'text': 'Edukasi', 'bg': const Color(0xFF075E94), 'fg': Colors.white},
      ],
      'paragraphs': [
        {
          'type': 'heading',
          'text': '• Fakta Ilmiah & Fisik'
        },
        {
          'type': 'list_item',
          'number': '',
          'title': 'Nama & Klasifikasi ',
          'desc': 'Ikan dewa memiliki nama latin Tor soro dan termasuk ke dalam genus Tor. Ikan ini punya banyak nama berbeda di berbagai daerah di Jawa Barat disebut Kancra, di Jawa Tengah/Timur disebut Tombro, sementara di Sumatera dikenal dengan nama Semah, Batak, Ihan, Masheer, atau Kelah.'
        },
        {
          'type': 'list_item',
          'number': '',
          'title': 'Ukuran Luar Biasa ',
          'desc': 'Ikan dewa bisa tumbuh sepanjang satu meter dengan bobot lebih dari 30 kg, namun butuh waktu belasan hingga puluhan tahun untuk mencapai ukuran tersebut. Pertumbuhannya tergolong sangat lambat bahkan untuk mencapai ukuran konsumsi saja diperkirakan perlu lebih dari satu tahun.'
        },
        {
          'type': 'list_item',
          'number': '',
          'title': 'Tubuh & Habitat ',
          'desc': 'Secara fisik, ikan dewa memiliki tubuh yang gagah dengan sisik keras dan besar. Mereka hanya bisa hidup di kolam dengan mata air yang jernih dan mengalir langsung dari pegunungan.'
        },
        {
          'type': 'heading',
          'text': '• Keunikan Fisik yang Aneh'
        },
        {
          'type': 'list_item',
          'number': '',
          'title': 'Tidak Punya Gigi ',
          'desc': 'Ikan dewa tidak memiliki gigi. Ketika pengunjung memberi makan, mereka bisa merasakan mulut ikan dewa yang melumat jari tanpa gigi sama sekali.'
        },
        {
          'type': 'list_item',
          'number': '',
          'title': 'Cara Makan Seperti Manusia ',
          'desc': 'Ikan dewa memiliki cara makan yang unik mereka membuang kulit dari makanan yang dikonsumsi, misalnya kacang kulit; isinya dimakan dan kulitnya disemburkan kembali. Makanan favoritnya adalah apel merah.'
        },
        {
          'type': 'heading',
          'text': '• Fakta Habitat & Populasi'
        },
        {
          'type': 'list_item',
          'number': '',
          'title': 'Hanya Ada di Lokasi Tertentu ',
          'desc': 'Ikan dewa hanya hidup di kolam-kolam tertentu di Kuningan, yaitu di Cibulan, Cigugur, Pasawahan, Linggarjati, dan Darmaloka. Ikan ini tidak bisa tinggal di tempat lain, bahkan di kolam yang airnya berasal dari limpahan kolam tersebut sekalipun.'
        },
        {
          'type': 'list_item',
          'number': '',
          'title': 'Jinak & Tidak Takut Manusia ',
          'desc': 'Ikan dewa tidak takut didekati manusia mereka justru akan mendekat untuk mendapatkan makanan. Pengunjung bahkan bisa berenang bersama ikan-ikan ini di kolam Cibulan.'
        },
        {
          'type': 'list_item',
          'number': '',
          'title': 'Suka Bergerombol ',
          'desc': 'Ikan dewa memiliki tingkah laku senang hidup bergerombol. Di Cibulan, mereka hidup bersama dalam satu kelompok dan memiliki kebiasaan unik: saat kolam dikuras, ikan-ikan ini menghilang secara bersamaan, lalu kembali dengan sendirinya setelah air terisi kembali.'
        },
        {
          'type': 'heading',
          'text': '• Status Konservasi'
        },
        {
          'type': 'list_item',
          'number': '',
          'title': 'Terancam Punah & Dilindungi Hukum ',
          'desc': 'Ikan dewa merupakan salah satu jenis ikan yang langka dan terancam punah. Karena itu, Pemerintah Kabupaten Kuningan membuat Peraturan Daerah Nomor 10 Tahun 2009 tentang Pelestarian Satwa Burung dan Ikan yang melindungi ikan dewa secara resmi.'
        },
        {
          'type': 'list_item',
          'number': '',
          'title': 'Rentan Penyakit ',
          'desc': 'Dari uji laboratorium pada kasus kematian massal di Cibulan (2022), ditemukan bahwa ikan dewa terserang dua jenis bakteri sekaligus, yaitu Aeromonas Salmonidae dan Edwardsiella Ictaluri, ditambah serangan parasit.'
        }
      ]
    },
    {
      'title': 'Lokasi Wisata Ikan Dewa Cl..',
      'fullTitle': 'Lokasi Wisata Ikan Dewa Cibulan',
      'detailTitle': 'Lokasi Wisata Air Cibulan',
      'desc': 'Panduan lengkap menuju Cibulan, fasilitas wisata, harga tiket, dan tips...',
      'image': 'assets/images/lokasi_wisata.png',
      'icon': Icons.location_on_rounded,
      'iconColor': const Color(0xFF1B5E20),
      'actionText': 'Lihat Lokasi',
      'actionColor': const Color(0xFF1B5E20),
      'badges': [
        {'text': 'Wisata', 'bg': const Color(0xFFE0F2F1), 'fg': const Color(0xFF00796B)},
        {'text': 'Rekreasi', 'bg': const Color(0xFFFFF3E0), 'fg': const Color(0xFFE65100)},
      ],
      'paragraphs': [
        'Objek wisata pemandian alam Cibulan terletak di Desa Maniskidul, Kecamatan Jalaksana, Kabupaten Kuningan. Tempat wisata ini diresmikan sejak tahun 1939 dan merupakan salah satu destinasi wisata tertua dan paling legendaris di Kuningan.',
        'Di Cibulan, terdapat beberapa kolam pemandian air dingin yang sangat jernih karena bersumber langsung dari mata air Gunung Ciremai. Kolam-kolam ini dipenuhi oleh ratusan ekor Ikan Dewa dari berbagai ukuran, mulai dari yang berukuran sedang hingga yang panjangnya mencapai satu meter.',
        'Selain berenang bersama Ikan Dewa, pemandian Cibulan juga terkenal dengan situs sejarah petilasan Prabu Siliwangi dan Tujuh Sumur Kramat. Fasilitas penunjang seperti area kuliner, mushola, toilet, dan gazebo yang teduh membuat tempat ini sangat nyaman untuk rekreasi keluarga.'
      ]
    },
  ];

  Future<void> _launchMapsUrl() async {
    final Uri url = Uri.parse('https://www.google.com/maps/search/?api=1&query=Pemandian+Alam+Cibulan+Kuningan');
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching maps: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedMaterialIndex != null) {
      return _buildDetailPage(context, _selectedMaterialIndex!);
    }
    return _buildListPage(context);
  }

  Widget _buildListPage(BuildContext context) {
    return Scaffold(
      key: const ValueKey('material_list_scaffold'),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'DewaFish Explore',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 22,
              color: Color(0xFF0E5482),
              letterSpacing: -0.5,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Header Section
            const Padding(
              padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 20.0),
              child: Text(
                'Materi Pembelajaran',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0E5482),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 8.0, bottom: 16.0),
              child: Text(
                'Jelajahi informasi lengkap mengenai Ikan Dewa dan habitatnya di Kuningan.',
                style: TextStyle(
                  fontSize: 14.5,
                  color: Color(0xFF555555),
                  height: 1.4,
                ),
              ),
            ),
            // Cards List
            ...materials.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A000000), // 4% opacity black
                      blurRadius: 16,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cover Image
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: AspectRatio(
                        aspectRatio: 1.85, // Matches aspect ratio from reference
                        child: Image.asset(
                          item['image'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFFD4E7F5),
                              child: const Icon(
                                Icons.image_not_supported_rounded,
                                color: Color(0xFF075E94),
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Card Body Content
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon + Title Row
                          Row(
                            children: [
                              Icon(
                                item['icon'],
                                color: item['iconColor'],
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item['title'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF222222),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Description Text
                          Text(
                            item['desc'],
                            style: const TextStyle(
                              fontSize: 14.5,
                              color: Color(0xFF666666),
                              height: 1.45,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Action Button Link
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedMaterialIndex = index;
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  item['actionText'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: item['actionColor'],
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 16,
                                  color: item['actionColor'],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailPage(BuildContext context, int index) {
    final item = materials[index];
    final List<Map<String, dynamic>> badges = item['badges'] as List<Map<String, dynamic>>;
    final List<dynamic> paragraphs = item['paragraphs'] as List<dynamic>;

    return Scaffold(
      key: ValueKey('material_detail_scaffold_$index'),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0E5482)),
          onPressed: () {
            setState(() {
              _selectedMaterialIndex = null;
            });
          },
        ),
        title: const Text(
          'DewaFish Explore',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 22,
            color: Color(0xFF0E5482),
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 1.85,
                child: Image.asset(
                  item['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFD4E7F5),
                      child: const Icon(
                        Icons.image_not_supported_rounded,
                        color: Color(0xFF075E94),
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Title
            Text(
              item['detailTitle'] ?? item['title'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0E5482),
              ),
            ),
            const SizedBox(height: 12),
            // Badges Row
            Row(
              children: badges.map((badge) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: badge['bg'] as Color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    badge['text'] as String,
                    style: TextStyle(
                      color: badge['fg'] as Color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            // Paragraphs
            ...paragraphs.map((para) {
              if (para is String) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    para,
                    style: const TextStyle(
                      fontSize: 15.5,
                      color: Color(0xFF444444),
                      height: 1.6,
                    ),
                  ),
                );
              } else if (para is Map<String, dynamic>) {
                final type = para['type'] as String;
                if (type == 'text_with_link') {
                  final text = para['text'] as String;
                  final linkText = para['linkText'] as String;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: text),
                          TextSpan(
                            text: linkText,
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      style: const TextStyle(
                        fontSize: 15.5,
                        color: Color(0xFF444444),
                        height: 1.6,
                      ),
                    ),
                  );
                } else if (type == 'heading') {
                  final text = para['text'] as String;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF222222),
                      ),
                    ),
                  );
                } else if (type == 'list_item') {
                  final number = para['number'] as String;
                  final title = para['title'] as String;
                  final desc = para['desc'] as String;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '$number$title',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: desc),
                        ],
                      ),
                      style: const TextStyle(
                        fontSize: 15.5,
                        color: Color(0xFF444444),
                        height: 1.6,
                      ),
                    ),
                  );
                }
              }
              return const SizedBox.shrink();
            }),
            if (index == 3) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _launchMapsUrl,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B5E20),
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.map_rounded),
                  label: const Text(
                    'Buka Petunjuk Arah',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

  // PREMIUM QUIZ SCREEN FOR INTERACTIVE TAB
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<Map<String, dynamic>> _shuffledQuestions;
  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  bool _submitted = false;
  int _score = 0;
  bool _showResult = false;

  final List<Map<String, dynamic>> _quizData = [
    {
      'question': 'Apa nama ilmiah (latin) dari Ikan Dewa?',
      'options': [
        {'text': 'Cyprinus carpio', 'isCorrect': false},
        {'text': 'Tor douronensis', 'isCorrect': true},
        {'text': 'Oreochromis niloticus', 'isCorrect': false},
        {'text': 'Clarias gariepinus', 'isCorrect': false},
      ],
      'explanation': 'Ikan Dewa dikenal secara ilmiah sebagai Tor douronensis (atau Tor soro) yang merupakan keluarga Cyprinidae.'
    },
    {
      'question': 'Menurut legenda masyarakat Kuningan, Ikan Dewa dipercaya sebagai jelmaan dari prajurit siapa?',
      'options': [
        {'text': 'Gajah Mada', 'isCorrect': false},
        {'text': 'Prabu Siliwangi', 'isCorrect': true},
        {'text': 'Raden Wijaya', 'isCorrect': false},
        {'text': 'Sultan Agung', 'isCorrect': false},
      ],
      'explanation': 'Menurut legenda lokal, Ikan Dewa diyakini sebagai jelmaan prajurit Prabu Siliwangi yang dikutuk.'
    },
    {
      'question': 'Mengapa prajurit Prabu Siliwangi dikutuk menjadi Ikan Dewa?',
      'options': [
        {'text': 'Karena membangkang dan tidak setia', 'isCorrect': true},
        {'text': 'Karena mencuri pusaka kerajaan', 'isCorrect': false},
        {'text': 'Karena melarikan diri ke hutan', 'isCorrect': false},
        {'text': 'Karena kalah dalam peperangan', 'isCorrect': false},
      ],
      'explanation': 'Para prajurit dikutuk menjadi ikan oleh Prabu Siliwangi karena melakukan pembangkangan dan pengkhianatan.'
    },
    {
      'question': 'Menurut mitos, prajurit tidak setia yang melarikan diri ke darat berubah menjadi...',
      'options': [
        {'text': 'Harimau', 'isCorrect': true},
        {'text': 'Elang', 'isCorrect': false},
        {'text': 'Ular Raksasa', 'isCorrect': false},
        {'text': 'Kera Putih', 'isCorrect': false},
      ],
      'explanation': 'Prajurit yang lari ke perairan dikutuk menjadi ikan, sedangkan yang lari ke darat dipercaya berubah menjadi harimau.'
    },
    {
      'question': 'Selain legenda Prabu Siliwangi, versi lain menyebutkan Ikan Dewa dibawa oleh murid...',
      'options': [
        {'text': 'Wali Songo', 'isCorrect': true},
        {'text': 'Prabu Kian Santang', 'isCorrect': false},
        {'text': 'Sunan Gunung Jati', 'isCorrect': false},
        {'text': 'Prabu Siliwangi', 'isCorrect': false},
      ],
      'explanation': 'Menurut versi Disporapar Kuningan, ikan dewa konon dibawa oleh murid Wali Songo saat datang ke Cibulan.'
    },
    {
      'question': 'Apa yang unik dari cara makan Ikan Dewa saat diberi makan kacang kulit?',
      'options': [
        {'text': 'Membuang kulitnya dan menyemburkannya kembali', 'isCorrect': true},
        {'text': 'Memakan langsung beserta kulitnya', 'isCorrect': false},
        {'text': 'Menghancurkannya dengan gigi tajam', 'isCorrect': false},
        {'text': 'Menyimpan kacang di bawah batu kolam', 'isCorrect': false},
      ],
      'explanation': 'Ikan Dewa membuang kulit kacang dengan cara memakan isinya lalu menyemburkan kembali kulitnya ke air.'
    },
    {
      'question': 'Mengapa pengunjung tidak merasa sakit saat jarinya dilumat oleh Ikan Dewa?',
      'options': [
        {'text': 'Karena Ikan Dewa tidak memiliki gigi', 'isCorrect': true},
        {'text': 'Karena giginya sangat tumpul', 'isCorrect': false},
        {'text': 'Karena memiliki air liur yang licin', 'isCorrect': false},
        {'text': 'Karena melumat dengan sangat lambat', 'isCorrect': false},
      ],
      'explanation': 'Ikan Dewa tidak memiliki gigi sama sekali, sehingga pengunjung hanya merasakan sensasi lumatan lembut di jari mereka.'
    },
    {
      'question': 'Di desa manakah lokasi objek wisata pemandian alam Cibulan berada?',
      'options': [
        {'text': 'Desa Maniskidul', 'isCorrect': true},
        {'text': 'Desa Cigugur', 'isCorrect': false},
        {'text': 'Desa Darmaloka', 'isCorrect': false},
        {'text': 'Desa Jalaksana', 'isCorrect': false},
      ],
      'explanation': 'Pemandian alam Cibulan terletak secara administratif di Desa Maniskidul, Kecamatan Jalaksana, Kuningan.'
    },
    {
      'question': 'Sejak tahun berapakah objek wisata alam air Cibulan resmi didirikan?',
      'options': [
        {'text': 'Tahun 1939', 'isCorrect': true},
        {'text': 'Tahun 1945', 'isCorrect': false},
        {'text': 'Tahun 1950', 'isCorrect': false},
        {'text': 'Tahun 1928', 'isCorrect': false},
      ],
      'explanation': 'Pemandian alam Cibulan diresmikan sejak tahun 1939 dan merupakan salah satu wisata tertua di Kuningan.'
    },
    {
      'question': 'Tujuh sumur kramat yang ditinggalkan oleh murid Wali Songo di Cibulan digunakan untuk...',
      'options': [
        {'text': 'Berwudhu', 'isCorrect': true},
        {'text': 'Mandi tobat', 'isCorrect': false},
        {'text': 'Membersihkan senjata pusaka', 'isCorrect': false},
        {'text': 'Minum air suci', 'isCorrect': false},
      ],
      'explanation': 'Tujih sumur kramat peninggalan murid Wali Songo digunakan untuk berwudhu dan masih disakralkan hingga kini.'
    }
  ];

  @override
  void initState() {
    super.initState();
    _resetQuiz();
  }

  void _resetQuiz() {
    _shuffledQuestions = List.from(_quizData);
    _shuffledQuestions.shuffle();
    for (var q in _shuffledQuestions) {
      final options = List<Map<String, dynamic>>.from(q['options']);
      options.shuffle();
      q['shuffledOptions'] = options;
    }
    _currentQuestionIndex = 0;
    _selectedAnswerIndex = null;
    _submitted = false;
    _score = 0;
    _showResult = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Kuis Interaktif',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0E5482),
          ),
        ),
        centerTitle: true,
      ),
      body: _showResult ? _buildResultPage() : _buildQuizPage(),
    );
  }

  Widget _buildQuizPage() {
    final currentQuestion = _shuffledQuestions[_currentQuestionIndex];
    final List<Map<String, dynamic>> shuffledOptions =
        currentQuestion['shuffledOptions'] as List<Map<String, dynamic>>;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Tracker Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: const BoxDecoration(
                  color: Color(0x1A075E94),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Text(
                  'Pertanyaan ${_currentQuestionIndex + 1} dari 10',
                  style: const TextStyle(
                    color: Color(0xFF075E94),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                'Skor: $_score',
                style: const TextStyle(
                  color: Color(0xFF555555),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Question Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x05000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              currentQuestion['question'] as String,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.55,
                color: Color(0xFF222222),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Options List
          ...List.generate(shuffledOptions.length, (index) {
            final option = shuffledOptions[index];
            final prefix = ['A', 'B', 'C', 'D'][index];
            Color itemBg = Colors.white;
            Color borderCol = Colors.grey.shade300;
            Color textCol = Colors.black87;

            if (_selectedAnswerIndex == index) {
              if (_submitted) {
                if (option['isCorrect'] as bool) {
                  itemBg = const Color(0xFFE8F5E9);
                  borderCol = Colors.green;
                  textCol = Colors.green.shade800;
                } else {
                  itemBg = const Color(0xFFFFEBEE);
                  borderCol = Colors.red;
                  textCol = Colors.red.shade800;
                }
              } else {
                itemBg = const Color(0xFFE3F2FD);
                borderCol = const Color(0xFF075E94);
                textCol = const Color(0xFF075E94);
              }
            } else if (_submitted && (option['isCorrect'] as bool)) {
              itemBg = const Color(0xFFE8F5E9);
              borderCol = Colors.green;
              textCol = Colors.green.shade800;
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _submitted
                    ? null
                    : () {
                        setState(() {
                          _selectedAnswerIndex = index;
                        });
                      },
                style: OutlinedButton.styleFrom(
                  backgroundColor: itemBg,
                  side: BorderSide(color: borderCol, width: 1.5),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '$prefix. ${option['text']}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: _selectedAnswerIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: textCol,
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 20),
          // Check Answer or Next Question Button
          if (!_submitted)
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _selectedAnswerIndex == null
                    ? null
                    : () {
                        setState(() {
                          _submitted = true;
                          final selectedOption = shuffledOptions[_selectedAnswerIndex!];
                          if (selectedOption['isCorrect'] as bool) {
                            _score += 10;
                          }
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF075E94),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 1,
                ),
                child: const Text(
                  'Periksa Jawaban',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )
          else ...[
            // Explanation Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: (shuffledOptions[_selectedAnswerIndex!]['isCorrect'] as bool)
                    ? const Color(0xFFE8F5E9)
                    : const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: (shuffledOptions[_selectedAnswerIndex!]['isCorrect'] as bool)
                      ? Colors.green.shade200
                      : Colors.red.shade200,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        (shuffledOptions[_selectedAnswerIndex!]['isCorrect'] as bool)
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded,
                        color: (shuffledOptions[_selectedAnswerIndex!]['isCorrect'] as bool)
                            ? Colors.green.shade700
                            : Colors.red.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        (shuffledOptions[_selectedAnswerIndex!]['isCorrect'] as bool)
                            ? 'Jawaban Benar'
                            : 'Jawaban Salah',
                        style: TextStyle(
                          color: (shuffledOptions[_selectedAnswerIndex!]['isCorrect'] as bool)
                              ? Colors.green.shade800
                              : Colors.red.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    currentQuestion['explanation'] as String,
                    style: TextStyle(
                      color: (shuffledOptions[_selectedAnswerIndex!]['isCorrect'] as bool)
                          ? Colors.green.shade900
                          : Colors.red.shade900,
                      fontSize: 13.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Next Question Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_currentQuestionIndex < 9) {
                      _currentQuestionIndex++;
                      _selectedAnswerIndex = null;
                      _submitted = false;
                    } else {
                      _showResult = true;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF145238),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  _currentQuestionIndex < 9 ? 'Pertanyaan Selanjutnya' : 'Lihat Hasil Kuis',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResultPage() {
    final int benar = _score ~/ 10;
    final int salah = 10 - benar;
    String feedback = '';
    IconData feedbackIcon = Icons.stars_rounded;
    Color feedbackColor = const Color(0xFF075E94);

    if (_score == 100) {
      feedback = 'Luar biasa! Skor Sempurna. Kamu telah menguasai semua materi Ikan Dewa!';
      feedbackIcon = Icons.emoji_events_rounded;
      feedbackColor = Colors.amber.shade700;
    } else if (_score >= 70) {
      feedback = 'Hebat! Kamu memahami materi ini dengan sangat baik.';
      feedbackIcon = Icons.thumb_up_rounded;
      feedbackColor = const Color(0xFF145238);
    } else if (_score >= 40) {
      feedback = 'Bagus! Terus tingkatkan dan baca materi kembali untuk hasil sempurna.';
      feedbackIcon = Icons.info_outline;
      feedbackColor = const Color(0xFF075E94);
    } else {
      feedback = 'Jangan menyerah! Coba baca kembali materi pembelajaran dan ulangi kuis.';
      feedbackIcon = Icons.sentiment_dissatisfied_rounded;
      feedbackColor = Colors.red.shade700;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          // Feedback Icon
          Icon(
            feedbackIcon,
            size: 80,
            color: feedbackColor,
          ),
          const SizedBox(height: 20),
          const Text(
            'Kuis Selesai!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D1D1D),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              feedback,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF555555),
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Score Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x08000000),
                  blurRadius: 16,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                // Score Circle
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: feedbackColor.withAlpha(26),
                    border: Border.all(
                      color: feedbackColor.withAlpha(77),
                      width: 4,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$_score',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: feedbackColor,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Benar',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$benar',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey.shade300,
                    ),
                    Column(
                      children: [
                        const Text(
                          'Salah',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$salah',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Reset Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _resetQuiz();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF075E94),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Ulangi Kuis',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
