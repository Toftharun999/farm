import 'package:flutter/material.dart';

void main() {
  runApp(const KisanSevaApp());
}

class KisanSevaApp extends StatelessWidget {
  const KisanSevaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kisan Seva - Farm Labor Marketplace',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: Colors.green[800],
          secondary: Colors.orangeAccent,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

// --- Models ---
enum UserRole { farmer, worker }

class AppUser {
  final String id;
  final String name;
  final String location;
  final UserRole role;
  final double rating;
  final int completedJobs;
  final int noShowPercent;
  final bool isVerified;
  final String phone;

  AppUser({
    required this.id,
    required this.name,
    required this.location,
    required this.role,
    required this.phone,
    this.rating = 4.8,
    this.completedJobs = 15,
    this.noShowPercent = 0,
    this.isVerified = true,
  });
}

class Job {
  final String id;
  final String title;
  final String crop;
  final String location;
  final String distance;
  final String pay;
  final String farmerId;
  final String farmerName;
  final String phone;
  bool isApplied;
  bool isCompleted;

  Job({
    required this.id,
    required this.title,
    required this.crop,
    required this.location,
    required this.distance,
    required this.pay,
    required this.farmerId,
    required this.farmerName,
    required this.phone,
    this.isApplied = false,
    this.isCompleted = false,
  });
}

// --- Global Mock State (For Prototype Only) ---
AppUser? currentUser;
List<Job> allJobs = [
  Job(
    id: '1',
    title: 'Rice Harvesting / వరి కోత',
    crop: 'Rice / వరి',
    location: 'Nellore',
    distance: '2 km away',
    pay: '₹600/day',
    farmerId: 'f1',
    farmerName: 'Ramappa',
    phone: '9876543210',
  ),
  Job(
    id: '2',
    title: 'Pesticide Spraying / మందు కొట్టడం',
    crop: 'Chilli / మిర్చి',
    location: 'Guntur',
    distance: '5 km away',
    pay: '₹800/day',
    farmerId: 'f2',
    farmerName: 'Venkatesh',
    phone: '9876543211',
  ),
  Job(
    id: '3',
    title: 'Tractor Driving / ట్రాక్టర్ డ్రైవింగ్',
    crop: 'Cotton / ప్రత్తి',
    location: 'Vijayawada',
    distance: '10 km away',
    pay: '₹1000/day',
    farmerId: 'f3',
    farmerName: 'Krishna Rao',
    phone: '9876543212',
  ),
];

// --- Common UI Components ---
class VoiceHelpButton extends StatelessWidget {
  const VoiceHelpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Playing voice instructions in your language...')),
          );
        },
        icon: const Icon(Icons.mic, size: 32),
        label: const Text('Voice Help / సహాయం'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange.shade100,
          foregroundColor: Colors.orange.shade900,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          elevation: 0,
        ),
      ),
    );
  }
}

// --- Screens ---

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade50, Colors.white],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.agriculture, size: 130, color: Colors.green),
            const SizedBox(height: 10),
            Text(
              'KISAN SEVA',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900, color: Colors.green[900]),
            ),
            const Text(
              'Farm Labor Marketplace\nరైతు కూలీల వేదిక',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 18),
            ),
            const SizedBox(height: 50),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number / ఫోన్ నంబర్',
                prefixText: '+91 ',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.phone,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RoleSelectionScreen()));
              },
              child: const Text('GET OTP / ఓటిపి పొందండి'),
            ),
            const SizedBox(height: 30),
            const VoiceHelpButton(),
          ],
        ),
      ),
    );
  }
}

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Role / పాత్రను ఎంచుకోండి')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildRoleCard(
              context,
              'I am a Farmer\nనేను రైతును',
              'Hire workers for my farm\nనాకు పనివారు కావాలి',
              Icons.person,
              Colors.green.shade50,
              () {
                currentUser = AppUser(id: 'f1', name: 'Ramappa', location: 'Guntur', role: UserRole.farmer, phone: '9876543210');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FarmerDashboard()));
              },
            ),
            const SizedBox(height: 30),
            _buildRoleCard(
              context,
              'I am a Worker\nనేను పనివాడిని',
              'Find jobs nearby\nనేను పని కోసం చూస్తున్నాను',
              Icons.engineering,
              Colors.orange.shade50,
              () {
                currentUser = AppUser(id: 'w1', name: 'Siva', location: 'Nellore', role: UserRole.worker, phone: '8765432109');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WorkerDashboard()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, String title, String sub, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(35),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.green.withValues(alpha: 0.4), width: 4),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 15, offset: const Offset(0, 8))],
        ),
        child: Row(
          children: [
            Icon(icon, size: 85, color: Colors.green[800]),
            const SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, height: 1.2)),
                  const SizedBox(height: 10),
                  Text(sub, style: const TextStyle(fontSize: 18, color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({super.key});

  @override
  State<FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  @override
  Widget build(BuildContext context) {
    final myJobs = allJobs.where((j) => j.farmerId == currentUser?.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Home / రైతు హోమ్'),
        backgroundColor: Colors.green[100],
        actions: [
          IconButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildProfileCard(),
          const SizedBox(height: 30),
          const Text('Your Job Posts / మీ పని ప్రకటనలు', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          if (myJobs.isEmpty)
            const Center(child: Padding(padding: EdgeInsets.all(40), child: Text('No jobs posted yet.\nపని ఇవ్వడానికి "+" నొక్కండి', textAlign: TextAlign.center, style: TextStyle(fontSize: 18))))
          else
            ...myJobs.map((job) => _buildJobItem(job)),
          const SizedBox(height: 20),
          const VoiceHelpButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showPostJobDialog(context),
        label: const Text('POST JOB / పని ఇవ్వండి', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.add_circle, size: 35),
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.shade200, width: 2),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 45, backgroundColor: Colors.green, child: Icon(Icons.person, size: 55, color: Colors.white)),
          const SizedBox(width: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(currentUser?.name ?? '', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 26),
                  Text(' ${currentUser?.rating} Rating', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const Text('Aadhaar Verified ✅', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJobItem(Job job) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        title: Text(job.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        subtitle: Text('🌾 Crop: ${job.crop}\n📍 ${job.location}', style: const TextStyle(fontSize: 18)),
        trailing: Text(job.pay, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 22)),
      ),
    );
  }

  void _showPostJobDialog(BuildContext context) {
    final tC = TextEditingController(), cC = TextEditingController(), pC = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(35))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 25, right: 25, top: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Post New Job / పని ఇవ్వండి', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(controller: tC, decoration: const InputDecoration(labelText: 'Work Name (Rice Cutting)', border: OutlineInputBorder())),
            const SizedBox(height: 15),
            TextField(controller: cC, decoration: const InputDecoration(labelText: 'Crop', border: OutlineInputBorder())),
            const SizedBox(height: 15),
            TextField(controller: pC, decoration: const InputDecoration(labelText: 'Salary (₹500/day)', border: OutlineInputBorder())),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800], foregroundColor: Colors.white),
              onPressed: () {
                if (tC.text.isNotEmpty) {
                  setState(() => allJobs.add(Job(id: DateTime.now().toString(), title: tC.text, crop: cC.text, location: currentUser!.location, distance: 'Nearby', pay: pC.text, farmerId: currentUser!.id, farmerName: currentUser!.name, phone: currentUser!.phone)));
                  Navigator.pop(context);
                }
              },
              child: const Text('POST NOW / ఇప్పుడే ప్రకటించండి'),
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}

class WorkerDashboard extends StatefulWidget {
  const WorkerDashboard({super.key});

  @override
  State<WorkerDashboard> createState() => _WorkerDashboardState();
}

class _WorkerDashboardState extends State<WorkerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Work / పని వెతకండి'),
        backgroundColor: Colors.green[100],
        actions: [
          IconButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          _buildWorkerHeader(),
          const SizedBox(height: 30),
          const Text('Available Jobs / అందుబాటులో ఉన్న పనులు', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          ...allJobs.map((job) => _buildJobCard(job)),
          const VoiceHelpButton(),
        ],
      ),
    );
  }

  Widget _buildWorkerHeader() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.orange.shade200, width: 2),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 40, backgroundColor: Colors.orange, child: Icon(Icons.engineering, size: 55, color: Colors.white)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(currentUser?.name ?? '', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  Text('⭐ ${currentUser?.rating} | ${currentUser?.completedJobs} Jobs done', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('No-show: ${currentUser?.noShowPercent}%', style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ],
          ),
          const Divider(height: 40, thickness: 1),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified, color: Colors.green, size: 28),
              SizedBox(width: 10),
              Text('ID Verified / ఆధార్ వెరిఫైడ్', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(Job job) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.only(bottom: 25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(job.title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, height: 1.1))),
                Text(job.pay, style: const TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 15),
            Text('Farmer: ${job.farmerName}', style: const TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w500)),
            const Divider(height: 40, thickness: 1),
            Row(
              children: [
                const Icon(Icons.eco, color: Colors.green, size: 24),
                const SizedBox(width: 10),
                Text('Crop: ${job.crop}', style: const TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red, size: 24),
                const SizedBox(width: 10),
                Text(' ${job.distance} (${job.location})', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 35),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _callFarmer(job.phone),
                    icon: const Icon(Icons.call, size: 35),
                    label: const Text('CALL / ఫోన్', style: TextStyle(fontSize: 20)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue[900],
                      side: BorderSide(color: Colors.blue[900]!, width: 3),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: job.isApplied ? null : () => _apply(job),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Text(job.isApplied ? 'Applied' : 'APPLY / అప్లై', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _callFarmer(String phone) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Calling Farmer: $phone...', style: const TextStyle(fontSize: 20)),
      backgroundColor: Colors.blue[800],
      duration: const Duration(seconds: 3),
    ));
  }

  void _apply(Job job) {
    setState(() => job.isApplied = true);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Success! The farmer will call you soon.\nసక్సెస్! రైతు మీకు ఫోన్ చేస్తారు.', style: TextStyle(fontSize: 18)),
      backgroundColor: Colors.green[700],
      duration: const Duration(seconds: 4),
    ));
  }
}
