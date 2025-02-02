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
TimeOfDay timeA = TimeOfDay.now(); // Variável para armazenar a hora

class InviteApp extends StatelessWidget {
  const InviteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove o banner de debug
      theme: ThemeData(
        primarySwatch: Colors.pink, // Tema romântico
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

class MemoryCarousel extends StatefulWidget {
  const MemoryCarousel({super.key});

  @override
  State<MemoryCarousel> createState() => _MemoryCarouselState();
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
  Memoria.image(
      image: 'assets/eu1.jpeg', message: "Já imaginar um date nosso..."),
  Memoria.image(
      image: 'assets/eu2.jpeg', message: "Malho p ficar bonita no date"),
  Memoria.image(image: 'assets/eu3.jpeg', message: ""),
  Memoria.image(image: 'assets/eu4.jpeg', message: ""),
  Memoria.image(image: 'assets/eu5.jpeg', message: ""),
];

class _MemoryCarouselState extends State<MemoryCarousel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: memorias.length,
            itemBuilder: (context, index) {
              final memory = memorias[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    memory.image,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
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
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _InviteHomePageState extends State<InviteHomePage> {
  final String girlName = 'Duda'; // Nome dela
  final String photoPath = 'assets/Sample3.jpeg'; // Foto dela
  final List<String> places = [
    'Bar',
    'Restaurante',
    'Museu',
    'Cinema',
  ];
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Exibindo a foto dela com efeito suave
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(photoPath),
              child: const Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.favorite, color: Colors.redAccent, size: 30),
              ),
            ),
            const SizedBox(height: 20),
            // Mensagem animada com efeito de digitação
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
            // Opções de lugares com ícones
            const Text(
              'Escolha o local:',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: places.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      leading: Icon(
                        icons[places[index]],
                        color: const Color(0xFFB39DDB),
                      ),
                      title: Text(places[index],
                          style: const TextStyle(fontSize: 18)),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        ).then((selectedDate) {
                          placeA = places[index];
                          dateA = selectedDate ?? DateTime.now();
                          if (selectedDate != null) {
                            // Após escolher a data, pede para escolher o horário
                            showTimePicker(
                              context: context,
                              initialTime: timeA,
                            ).then((selectedTime) {
                              timeA = selectedTime ?? TimeOfDay.now();
                              if (selectedTime != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SuccessScreen(
                                      place: places[index],
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
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MemoryCarousel()),
                );
              },
              child: buildSectionHeader('Fotos minhas p vc n me achar maluca'),
            ),
          ],
        ),
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
        Icon(Icons.arrow_forward_ios_outlined)
      ],
    ),
  );
}

// Tela de sucesso após marcar o encontro
class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key, required this.place, required this.date, required this.time});

  final String place;
  final DateTime date;
  final TimeOfDay time; // Hora marcada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle, // Ícone de sucesso
              color: Colors.green, // Cor do ícone
              size: 100, // Tamanho do ícone
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.place, color: Color(0xFFB39DDB), size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'Em um $place',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_today,
                        color: Color(0xFFB39DDB), size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'No dia ${formattedDate(date)}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.access_time,
                        color: Color(0xFFB39DDB), size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'Ás ${time.format(context)} hrs',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
}
