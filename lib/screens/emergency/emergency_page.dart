import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/common/top_header_widget.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../police/police_dashboard.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({super.key});

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Sample team members data
  final List<TeamMember> _teamMembers = [
    TeamMember(
      id: '1',
      name: 'Rajesh Kumar',
      phone: '+91 98765 43210',
      location: 'Delhi, India',
      isOnline: true,
      lastSeen: '2 minutes ago',
      avatar: '👨‍💼',
    ),
    TeamMember(
      id: '2',
      name: 'Priya Sharma',
      phone: '+91 87654 32109',
      location: 'Mumbai, India',
      isOnline: true,
      lastSeen: '5 minutes ago',
      avatar: '👩‍💼',
    ),
    TeamMember(
      id: '3',
      name: 'Amit Singh',
      phone: '+91 76543 21098',
      location: 'Bangalore, India',
      isOnline: false,
      lastSeen: '1 hour ago',
      avatar: '👨‍🔧',
    ),
    TeamMember(
      id: '4',
      name: 'Sneha Patel',
      phone: '+91 65432 10987',
      location: 'Ahmedabad, India',
      isOnline: true,
      lastSeen: '10 minutes ago',
      avatar: '👩‍⚕️',
    ),
    TeamMember(
      id: '5',
      name: 'Vikram Reddy',
      phone: '+91 54321 09876',
      location: 'Hyderabad, India',
      isOnline: false,
      lastSeen: '30 minutes ago',
      avatar: '👨‍🎓',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<TeamMember> get _filteredTeamMembers {
    if (_searchQuery.isEmpty) return _teamMembers;
    return _teamMembers
        .where((member) =>
            member.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SafeArea(
        child: Column(
          children: [
            // Top header with SOS and Profile
            TopHeaderWidget(onBackground: AppColors.onBackground),
            
            // Tab bar with animated line indicator
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
              child: Stack(
                children: [
                  TabBar(
                    controller: _tabController,
                    indicator: const BoxDecoration(),
                    labelColor: AppColors.onBackground,
                    unselectedLabelColor: AppColors.muted,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    tabs: const [
                      Tab(text: 'Help'),
                      Tab(text: 'Team Members'),
                    ],
                  ),
                  // Animated blue line indicator
                  AnimatedBuilder(
                    animation: _tabController,
                    builder: (context, child) {
                      final double animationValue = _tabController.animation?.value ?? 0.0;
                      final double tabWidth = MediaQuery.of(context).size.width - 32; // Account for margins
                      final double tabItemWidth = tabWidth / 2;
                      final double lineWidth = tabItemWidth * 0.5; // Half the width of each tab
                      final double lineStart = (tabItemWidth - lineWidth) / 2 + (animationValue * tabItemWidth);
                      
                      return Positioned(
                        left: lineStart,
                        bottom: 0,
                        child: Container(
                          width: lineWidth,
                          height: 3,
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(1.5),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildHelpSection(),
                  _buildTeamMembersSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpSection() {
    final List<HelpOption> helpOptions = [
      HelpOption(
        title: 'Police',
        subtitle: 'Emergency: 100',
        icon: Icons.local_police,
        color: Colors.blue,
        onTap: () => _navigateToPoliceDashboard(),
      ),
      HelpOption(
        title: 'Ambulance',
        subtitle: 'Medical Emergency: 108',
        icon: Icons.medical_services,
        color: Colors.red,
        onTap: () => _callEmergency('108'),
      ),
      HelpOption(
        title: 'Fire Department',
        subtitle: 'Fire Emergency: 101',
        icon: Icons.local_fire_department,
        color: Colors.orange,
        onTap: () => _callEmergency('101'),
      ),
      HelpOption(
        title: 'Women Helpline',
        subtitle: 'Women Safety: 1091',
        icon: Icons.woman,
        color: Colors.pink,
        onTap: () => _callEmergency('1091'),
      ),
      HelpOption(
        title: 'Disaster Management',
        subtitle: 'Disaster Relief: 108',
        icon: Icons.warning,
        color: Colors.amber,
        onTap: () => _callEmergency('108'),
      ),
      HelpOption(
        title: 'Tourist Helpline',
        subtitle: 'Tourist Support: 1363',
        icon: Icons.tour,
        color: Colors.green,
        onTap: () => _callEmergency('1363'),
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Emergency Contacts',
            style: AppTheme.sectionHeader,
          ),
          const SizedBox(height: 8),
          Text(
            'Tap on any service to call immediately',
            style: AppTheme.mutedText,
          ),
          const SizedBox(height: 20),
          
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: helpOptions.length,
            itemBuilder: (context, index) {
              final option = helpOptions[index];
              return _buildHelpOptionCard(option);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHelpOptionCard(HelpOption option) {
    return GestureDetector(
      onTap: option.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: option.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                option.icon,
                color: option.color,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              option.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.onBackground,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              option.subtitle,
              style: AppTheme.mutedText.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMembersSection() {
    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
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
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search team members...',
                hintStyle: AppTheme.mutedText,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.muted,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
        ),
        
        // Team members list
        Expanded(
          child: _filteredTeamMembers.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: AppColors.muted,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No team members found',
                        style: AppTheme.mutedText.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _filteredTeamMembers.length,
                  itemBuilder: (context, index) {
                    final member = _filteredTeamMembers[index];
                    return _buildTeamMemberCard(member);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildTeamMemberCard(TeamMember member) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
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
          backgroundColor: member.isOnline 
              ? AppColors.accent.withOpacity(0.1)
              : AppColors.muted.withOpacity(0.1),
          child: Text(
            member.avatar,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        title: Row(
          children: [
            Text(
              member.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.onBackground,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: member.isOnline ? Colors.green : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              member.location,
              style: AppTheme.mutedText.copyWith(fontSize: 14),
            ),
            Text(
              member.isOnline ? 'Online' : 'Last seen ${member.lastSeen}',
              style: AppTheme.mutedText.copyWith(fontSize: 12),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.muted,
        ),
        onTap: () => _showTeamMemberDetails(member),
      ),
    );
  }

  void _navigateToPoliceDashboard() {
    HapticFeedback.lightImpact();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PoliceDashboard(),
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
              // In a real app, you would use url_launcher to make the call
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

  void _showTeamMemberDetails(TeamMember member) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _TeamMemberDetailsModal(member: member),
    );
  }
}

class _TeamMemberDetailsModal extends StatelessWidget {
  final TeamMember member;

  const _TeamMemberDetailsModal({required this.member});

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
                  backgroundColor: member.isOnline 
                      ? AppColors.accent.withOpacity(0.1)
                      : AppColors.muted.withOpacity(0.1),
                  child: Text(
                    member.avatar,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.name,
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
                              color: member.isOnline ? Colors.green : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            member.isOnline ? 'Online' : 'Last seen ${member.lastSeen}',
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
          
          // Location section
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.scaffold,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.accent,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Current Location',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onBackground,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  member.location,
                  style: AppTheme.mutedText,
                ),
                const SizedBox(height: 16),
                // Placeholder for map
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.muted.withOpacity(0.1),
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
                        'Live Location Map',
                        style: AppTheme.mutedText,
                      ),
                      Text(
                        '(Placeholder)',
                        style: AppTheme.mutedText.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Contact section
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.scaffold,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: AppColors.accent,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Contact Number',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onBackground,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  member.phone,
                  style: AppTheme.mutedText.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
          
          const Spacer(),
          
          // Action buttons
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // In a real app, you would use url_launcher to make the call
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Calling ${member.phone}...'),
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
                      // In a real app, you would use url_launcher to send SMS
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sending SMS to ${member.phone}...'),
                          backgroundColor: AppColors.accent,
                        ),
                      );
                    },
                    icon: const Icon(Icons.message),
                    label: const Text('Message'),
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
}

// Data models
class HelpOption {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  HelpOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class TeamMember {
  final String id;
  final String name;
  final String phone;
  final String location;
  final bool isOnline;
  final String lastSeen;
  final String avatar;

  TeamMember({
    required this.id,
    required this.name,
    required this.phone,
    required this.location,
    required this.isOnline,
    required this.lastSeen,
    required this.avatar,
  });
}
