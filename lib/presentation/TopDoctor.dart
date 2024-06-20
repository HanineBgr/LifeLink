import 'package:flutter/material.dart';

class TopDoctor extends StatelessWidget {
  final List<Doctor> doctors = [
    Doctor(
      name: "Dr. Houria Abidi",
      specialty: "Cardiologist",
      imageUrl: 'assets/doc1.png',
      rating: 4.2,
      location: "2km ",
    ),
    Doctor(
      name: "Dr. Ahmed Salah",
      specialty: "Pediatrician",
      imageUrl: 'assets/doctor03.jpeg',
      rating: 4.5,
      location: "5km ",
    ),
    Doctor(
      name: "Dr. Ahmed Aziz ",
      specialty: "Orthopedic Surgeon",
      imageUrl: 'assets/doctor04.jpeg',
      rating: 4.8,
      location: "3km ",
    ),
    // Add more doctors as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
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
      width: 150,
      height: 160,
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
              height: 80,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(doctor.imageUrl),
                
                ),
              ),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 25),
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
