import 'package:flutter/material.dart';

class TopDoctor extends StatelessWidget {
  final List<Doctor> doctors = [
    Doctor(
      name: "Dr. Ahmed Salah",
      specialty: "Cardiologist",
      imageUrl: 'assets/doc1.png',
      rating: 4.2,
      location: "2km away",
    ),
    Doctor(
      name: "Dr. Sarah Said",
      specialty: "Pediatrician",
      imageUrl: 'assets/doc2.png',
      rating: 4.5,
      location: "5km away",
    ),
    Doctor(
      name: "Dr. John Doe",
      specialty: "Orthopedic Surgeon",
      imageUrl: 'assets/doc3.png',
      rating: 4.8,
      location: "3km away",
    ),
    // Add more doctors as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return DoctorCard(doctor: doctors[index]);
        },
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 170,
      height: 170,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(doctor.imageUrl),
                 // fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              doctor.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              doctor.specialty,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.yellow[700], size: 18),
                const SizedBox(width: 5),
                Text(doctor.rating.toString()),
                const SizedBox(width: 15),
                Icon(Icons.location_on, color: Colors.grey, size: 18),
                const SizedBox(width: 5),
                Text(
                  doctor.location,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Doctor {
  final String name;
  final String specialty;
  final String imageUrl;
  final double rating;
  final String location;

  Doctor({
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.location,
  });
}
