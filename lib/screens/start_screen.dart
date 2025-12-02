import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/responsive_scaffold.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      showAppBar: false,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "MEMORY MATCH", 
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold, 
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            
            const SizedBox(height: 10),

            const Text(
              "Train your memory!", 
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ), 

            const SizedBox(height: 50),

            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed('/levels');
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text("PLAY", style: TextStyle(fontSize: 18),),
              ),
            )



          ],
        ),
      ),
    );
  }




}