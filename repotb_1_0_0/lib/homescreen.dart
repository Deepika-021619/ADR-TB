import 'package:flutter/material.dart';
import 'consent_screen.dart';
class HomeScreen extends StatelessWidget{
    const HomeScreen({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.blue.shade100,
            appBar: AppBar(
                centerTitle: true,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "ADR-TB: Enhancing TB Care with Smart ADR Monitoring",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.3,
                      ),
                    ),
                    
                  ],
                ),
                backgroundColor: Colors.blue.shade400,
                foregroundColor: Colors.white,
            ),
              body: Stack(  // ✅ Stack for blue bg + image OVER it
        children: [
          // 1. Blue gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade200,
                  Colors.blue.shade400,
                  Colors.blue.shade600,
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(40),
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.contain,
                opacity: const AlwaysStoppedAnimation(1),  // ✅ Transparent logo
              ),
            ),
          ),
          // 3. Button OVER everything
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade500,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                ),
                onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ConsentScreen(
        portal: "Physician",
      ),
    ),
  );
},

                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.medical_services, size: 32, color: Colors.white),
                    SizedBox(width: 12),
                    Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 28,
                        
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
           