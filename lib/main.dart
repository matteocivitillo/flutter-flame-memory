import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => StorageService().init());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp( {super.key} );

  @override
  Widget build (BuildContext context){
    return GetMaterialApp(
      title: "Memory Game",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: "Arial"
      ),

      initialRoute: '/',

      getPages: [
        GetPage(name: '/', page: () => const StartScreenPlaceholder()),
        GetPage(name: '/levels', page: () => const Placeholder()),
        GetPage(name: '/game', page: () => const Placeholder()),
        ],
    );
  }
}

class StartScreenPlaceholder extends StatelessWidget {
  const StartScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Memory Match started"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final service = Get.find<StorageService>();
                print("Unlocked levels: ${service.getUnlockedLevels()}");
              }, 
              child: const Text ("Test Storage")
            )
          ],
        )
      )
    );
  }
}