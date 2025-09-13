import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/common/top_header_widget.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';

class PoliceDashboard extends StatefulWidget {
  const PoliceDashboard({super.key});

  @override
  State<PoliceDashboard> createState() => _PoliceDashboardState();
}

class _PoliceDashboardState extends State<PoliceDashboard> {
  String _selectedStation = '';
  final List<PoliceStation> _policeStations = [
    PoliceStation(
      id: '1',
      name: 'Central Police Station',
      address: '123 Main Street, Downtown',
      distance: '0.5 km',
      phone: '+91 98765 43210',
      isOpen: true,
      lat: 28.6139,
      lng: 77.2090,
      services: ['General Complaints', 'Traffic Violations', 'Emergency Response'],
      rating: 4.5,
    ),
    PoliceStation(
      id: '2',
      name: 'North Police Station',
      address: '456 North Avenue, Sector 15',
      distance: '1.2 km',
      phone: '+91 87654 32109',
      isOpen: true,
      lat: 28.6239,
      lng: 77.2190,
      services: ['Women Safety', 'Cyber Crimes', 'Community Policing'],
      rating: 4.3,
    ),
    PoliceStation(
      id: '3',
      name: 'South Police Station',
      address: '789 South Road, Sector 25',
      distance: '2.1 km',
      phone: '+91 76543 21098',
      isOpen: false,
      lat: 28.6039,
      lng: 77.1990,
      services: ['Traffic Management', 'Public Safety', 'Patrol Services'],
      rating: 4.1,
    ),
    PoliceStation(
      id: '4',
      name: 'East Police Station',
      address: '321 East Street, Sector 30',
      distance: '1.8 km',
      phone: '+91 65432 10987',
      isOpen: true,
      lat: 28.6339,
      lng: 77.2290,
      services: ['Drug Enforcement', 'Anti-Terrorism', 'VIP Security'],
      rating: 4.7,
    ),
    PoliceStation(
      id: '5',
      name: 'West Police Station',
      address: '654 West Boulevard, Sector 40',
      distance: '2.5 km',
      phone: '+91 54321 09876',
      isOpen: true,
      lat: 28.5939,
      lng: 77.1890,
      services: ['Crime Investigation', 'Forensic Support', 'Community Outreach'],
      rating: 4.4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SafeArea(
        child: Column(
          children: [
            // Top header with back button
            _buildHeader(),
            
            // Main content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Emergency alert banner
                    _buildEmergencyBanner(),
                    
                    const SizedBox(height: 20),
                    
                    // Map section
                    _buildMapSection(),
                    
                    const SizedBox(height: 20),
                    
                    // Quick actions
                    _buildQuickActions(),
                    
                    const SizedBox(height: 20),
                    
                    // Police stations list
                    _buildPoliceStationsList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.onBackground,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Police Dashboard',
                  style: AppTheme.sectionHeader,
                ),
                Text(
                  'Find nearby police stations and emergency contacts',
                  style: AppTheme.mutedText,
                ),
              ],
            ),
          ),
          // Emergency call button
          GestureDetector(
            onTap: () => _callEmergency('100'),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.phone,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFff6b6b), Color(0xFFee5a24)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.warning_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Emergency Alert',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'In case of emergency, call 100 immediately',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Map placeholder
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.muted.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map,
                  size: 64,
                  color: AppColors.muted,
                ),
                const SizedBox(height: 12),
                Text(
                  'Police Stations Map',
                  style: AppTheme.mutedText.copyWith(fontSize: 16),
                ),
                Text(
                  '(Interactive map with police station markers)',
                  style: AppTheme.mutedText.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          // Map controls
          Positioned(
            top: 12,
            right: 12,
            child: Row(
              children: [
                _buildMapControl(Icons.my_location, 'My Location'),
                const SizedBox(width: 8),
                _buildMapControl(Icons.layers, 'Layers'),
              ],
            ),
          ),
          // Police station markers (simulated)
          ..._policeStations.map((station) => _buildMapMarker(station)),
        ],
      ),
    );
  }

  Widget _buildMapControl(IconData icon, String tooltip) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: AppColors.onBackground,
        size: 20,
      ),
    );
  }

  Widget _buildMapMarker(PoliceStation station) {
    final double left = 50 + (station.lng - 77.1990) * 100; // Simulate positioning
    final double top = 100 + (28.6339 - station.lat) * 50; // Simulate positioning
    
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () => _showStationDetails(station),
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: station.isOpen ? Colors.green : Colors.red,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.local_police,
            color: Colors.white,
            size: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: AppTheme.sectionHeader,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'File Complaint',
                Icons.edit_document,
                Colors.blue,
                () => _showComplaintDialog(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                'Report Crime',
                Icons.report,
                Colors.red,
                () => _showReportDialog(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                'Safety Tips',
                Icons.security,
                Colors.green,
                () => _showSafetyTips(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                'Police Contacts',
                Icons.contacts,
                Colors.orange,
                () => _showContacts(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.onBackground,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPoliceStationsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nearby Police Stations',
          style: AppTheme.sectionHeader,
        ),
        const SizedBox(height: 12),
        ..._policeStations.map((station) => _buildStationCard(station)),
      ],
    );
  }

  Widget _buildStationCard(PoliceStation station) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: station.isOpen 
              ? Colors.green.withOpacity(0.1)
              : Colors.red.withOpacity(0.1),
          child: Icon(
            Icons.local_police,
            color: station.isOpen ? Colors.green : Colors.red,
            size: 24,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                station.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onBackground,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: station.isOpen ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                station.isOpen ? 'Open' : 'Closed',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 14,
                  color: AppColors.muted,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    station.address,
                    style: AppTheme.mutedText.copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.directions,
                  size: 14,
                  color: AppColors.muted,
                ),
                const SizedBox(width: 4),
                Text(
                  station.distance,
                  style: AppTheme.mutedText.copyWith(fontSize: 12),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.star,
                  size: 14,
                  color: Colors.amber,
                ),
                const SizedBox(width: 4),
                Text(
                  station.rating.toString(),
                  style: AppTheme.mutedText.copyWith(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => _callStation(station.phone),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.phone,
                  color: AppColors.accent,
                  size: 16,
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => _showStationDetails(station),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.muted,
              ),
            ),
          ],
        ),
        onTap: () => _showStationDetails(station),
      ),
    );
  }

  void _callEmergency(String number) {
    HapticFeedback.lightImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Call Emergency Service'),
        content: Text('Are you sure you want to call $number?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Calling $number...'),
                  backgroundColor: AppColors.accent,
                ),
              );
            },
            child: const Text('Call'),
          ),
        ],
      ),
    );
  }

  void _callStation(String phone) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Calling $phone...'),
        backgroundColor: AppColors.accent,
      ),
    );
  }

  void _showStationDetails(PoliceStation station) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _StationDetailsModal(station: station),
    );
  }

  void _showComplaintDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('File Complaint'),
        content: const Text('This feature will allow you to file a complaint online. Coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Crime'),
        content: const Text('This feature will allow you to report a crime anonymously. Coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSafetyTips() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Safety Tips'),
        content: const Text('• Always be aware of your surroundings\n• Keep emergency contacts handy\n• Trust your instincts\n• Report suspicious activities immediately'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showContacts() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Police Contacts'),
        content: const Text('Emergency: 100\nWomen Helpline: 1091\nTraffic Police: 1095\nCyber Crime: 1930'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _StationDetailsModal extends StatelessWidget {
  final PoliceStation station;

  const _StationDetailsModal({required this.station});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.muted.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: station.isOpen 
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  child: Icon(
                    Icons.local_police,
                    color: station.isOpen ? Colors.green : Colors.red,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        station.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onBackground,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: station.isOpen ? Colors.green : Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            station.isOpen ? 'Currently Open' : 'Currently Closed',
                            style: AppTheme.mutedText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Details sections
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contact info
                  _buildDetailSection(
                    'Contact Information',
                    Icons.phone,
                    [
                      'Phone: ${station.phone}',
                      'Distance: ${station.distance}',
                      'Rating: ${station.rating}/5.0',
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Address
                  _buildDetailSection(
                    'Address',
                    Icons.location_on,
                    [station.address],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Services
                  _buildDetailSection(
                    'Available Services',
                    Icons.list,
                    station.services,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Map placeholder
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.scaffold,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.muted.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map,
                          size: 48,
                          color: AppColors.muted,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Station Location Map',
                          style: AppTheme.mutedText,
                        ),
                        Text(
                          '(Interactive map with directions)',
                          style: AppTheme.mutedText.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Action buttons
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Calling ${station.phone}...'),
                          backgroundColor: AppColors.accent,
                        ),
                      );
                    },
                    icon: const Icon(Icons.phone),
                    label: const Text('Call'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.accent,
                      side: const BorderSide(color: AppColors.accent),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Getting directions...'),
                          backgroundColor: AppColors.accent,
                        ),
                      );
                    },
                    icon: const Icon(Icons.directions),
                    label: const Text('Directions'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, IconData icon, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.accent, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.onBackground,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            '• $item',
            style: AppTheme.mutedText,
          ),
        )),
      ],
    );
  }
}

// Data model
class PoliceStation {
  final String id;
  final String name;
  final String address;
  final String distance;
  final String phone;
  final bool isOpen;
  final double lat;
  final double lng;
  final List<String> services;
  final double rating;

  PoliceStation({
    required this.id,
    required this.name,
    required this.address,
    required this.distance,
    required this.phone,
    required this.isOpen,
    required this.lat,
    required this.lng,
    required this.services,
    required this.rating,
  });
}
