import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import 'car_screen.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({super.key});

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black45,

      body: Column(
        children: [

          // ---------------- TOP MODEL SECTION ----------------
          Stack(
            children: [
              SizedBox(
                height: 430,
                width: double.infinity,
                child: Container(
                  //color: Colors.black45,
                  child: const ModelViewer(
                    src: "assets/models/mclaren_600lt.glb",
                    autoRotate: true,
                    cameraControls: true,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),

              // ---------------- TOP LEFT ARROW BUTTON ----------------
              Positioned(
                top: 40,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CarScreen()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 26,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ---------------- BOTTOM WHITE CONTAINER ----------------
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // TITLE
                      Text(
                        "McLaren 600LT",
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // DESCRIPTION
                      Text(
                        "The McLaren 600LT is a lightweight, track-focused supercar "
                            "powered by a 592 HP twin-turbo V8. With extreme aerodynamics "
                            "and razor-sharp handling, it's built for pure performance.",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          height: 1.45,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // FEATURES
                      _buildFeature(Icons.speed, "Top Speed: 328 km/h"),
                      const SizedBox(height: 12),

                      _buildFeature(Icons.flash_on, "0–100 km/h in 2.9 sec"),
                      const SizedBox(height: 12),

                      _buildFeature(Icons.local_gas_station, "Twin-Turbocharged V8 Engine"),
                      const SizedBox(height: 12),

                      _buildFeature(Icons.sports_motorsports, "Track-Focused Aerodynamics"),

                      const SizedBox(height: 40),

                      // BUY BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.black87,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            "Buy Now",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),

              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------- FEATURE ROW COMPONENT --------------
  Widget _buildFeature(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.black87, size: 22),
        const SizedBox(width: 10),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
