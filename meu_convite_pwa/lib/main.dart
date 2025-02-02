import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const InviteApp());
}

String formattedDate(DateTime date) => DateFormat('dd/MM/yyyy').format(date);
String placeA = "";
DateTime dateA = DateTime.now();
TimeOfDay timeA = TimeOfDay.now();

class InviteApp extends StatelessWidget {
  const InviteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
      ),
      home: const InviteHomePage(),
    );
  }
}

class InviteHomePage extends StatefulWidget {
  const InviteHomePage({super.key});

  @override
  _InviteHomePageState createState() => _InviteHomePageState();
}

Future<void> launchWhatsApp(BuildContext context) async {
  final String inviteMessage = """
Eii, ameii o convite!! 🎉🎉   
Vamos para o *$placeA* no dia *${formattedDate(dateA)}* e às *${timeA.format(context)}* hrs, o que acha?😊""";

  const String phone = "31989183607";
  String phoneNumber = "https://wa.me/55$phone?text=";

  final link = WhatsAppUnilink(
    phoneNumber: phoneNumber,
    text: inviteMessage,
  );

  await launchUrlString('$link', mode: LaunchMode.externalApplication);
}

class _InviteHomePageState extends State<InviteHomePage> {
  final String girlName = 'Duda';
  final String photoPath = 'assets/Sample3.jpeg';
  final List<String> places = ['Bar', 'Restaurante', 'Museu', 'Cinema'];
  final Map<String, IconData> icons = {
    'Bar': Icons.local_bar,
    'Restaurante': Icons.restaurant,
    'Museu': Icons.house,
    'Cinema': Icons.movie,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '✨ Convite Especial ✨',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFB39DDB),
      ),
      floatingActionButton: ElevatedButton.icon(
          label: Text("Sobre mim"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MemoryCarousel()),
            );
          },
          icon: Icon(Icons.info)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(photoPath),
              child: const Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.favorite, color: Colors.redAccent, size: 30),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Eii $girlName, você está convidada para um encontro especial!',
                  textAlign: TextAlign.center,
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB39DDB),
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 1,
            ),
            const SizedBox(height: 20),
            const Text(
              'Escolha o local:',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: places.length,
                itemBuilder: (context, index) {
                  return buildPlaceCard(context, places[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPlaceCard(BuildContext context, String place) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Icon(
          icons[place],
          color: const Color(0xFFB39DDB),
        ),
        title: Text(place, style: const TextStyle(fontSize: 18)),
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          ).then((selectedDate) {
            if (selectedDate != null) {
              placeA = place;
              dateA = selectedDate;
              showTimePicker(
                context: context,
                initialTime: timeA,
              ).then((selectedTime) {
                if (selectedTime != null) {
                  timeA = selectedTime;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessScreen(
                        place: place,
                        date: selectedDate,
                        time: selectedTime,
                      ),
                    ),
                  );
                }
              });
            }
          });
        },
      ),
    );
  }
}

Widget buildSectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFB39DDB),
            ),
          ),
        ),
        const Icon(Icons.arrow_forward_ios_outlined)
      ],
    ),
  );
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key, required this.place, required this.date, required this.time});

  final String place;
  final DateTime date;
  final TimeOfDay time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Encontro marcado!',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB39DDB)),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildDetailRow(Icons.place, 'Em um $place'),
                const SizedBox(height: 10),
                buildDetailRow(
                    Icons.calendar_today, 'No dia ${formattedDate(date)}'),
                const SizedBox(height: 10),
                buildDetailRow(
                    Icons.access_time, 'Ás ${time.format(context)} hrs'),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                launchWhatsApp(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Enviar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Voltar ao convite'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: const Color(0xFFB39DDB), size: 24),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class Memoria {
  String image;
  String message;
  String url;
  bool isDownload;
  bool isNetwork;
  Memoria.image(
      {required this.image,
      required this.message,
      this.url = '',
      this.isNetwork = false,
      this.isDownload = false});
}

var memorias = [
  // Sobre Mim
  Memoria.image(
    image: 'assets/eu1.jpeg',
    message:
        "Sou de BH e, como vc pode imaginar, trabalho desenvolvendo aplicativos...",
  ),
  Memoria.image(
    image: 'assets/eu3.jpeg',
    message:
        "Tenho 22 anos e nunca namorei, ou seja, n tenho histórico complicado...",
  ),
  Memoria.image(
    image: 'assets/eu2.jpeg',
    message: "Sou lésbica e assumida para toda a minha família...",
  ),

  // Motivação para o Date
  Memoria.image(
    image: 'assets/eu4.jpeg',
    message:
        "Quero apenas fazer um date. Desenvolvi este app porque imaginei que teria mais chances de vc responder...",
  ),
  Memoria.image(
    image: 'assets/eu5.jpeg',
    message: "Acho que vc deveria aceitar o convite só pela história...",
  ),
];

class MemoryCarousel extends StatefulWidget {
  const MemoryCarousel({super.key});

  @override
  State<MemoryCarousel> createState() => _MemoryCarouselState();
}

class _MemoryCarouselState extends State<MemoryCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Carrossel de fotos
          PageView.builder(
            controller: _pageController,
            itemCount: memorias.length,
            itemBuilder: (context, index) {
              final memory = memorias[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Imagem de fundo
                  Image.asset(
                    memory.image,
                    fit: BoxFit.cover,
                  ),
                  // Overlay escuro para melhorar a legibilidade do texto
                  Container(
                    color: Colors.black.withOpacity(0.4),
                  ),
                  // Mensagem centralizada (se existir)
                  if (memory.message.isNotEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          memory.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 10,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                memorias.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
