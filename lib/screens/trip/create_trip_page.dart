import 'package:flutter/material.dart';
import '../../widgets/common/top_header_widget.dart';

class CreateTripPage extends StatefulWidget {
  const CreateTripPage({super.key});

  @override
  State<CreateTripPage> createState() => _CreateTripPageState();
}

class _CreateTripPageState extends State<CreateTripPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _destinationController = TextEditingController();
  
  late DateTime _startDate;
  late DateTime _endDate;
  
  final List<String> _invitePublicIds = [];
  final List<String> _inviteEmails = [];
  
  final _publicIdController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set default dates
    _startDate = DateTime.now();
    _endDate = DateTime.now().add(const Duration(days: 1));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _destinationController.dispose();
    _publicIdController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _addPublicId() {
    final publicId = _publicIdController.text.trim().toUpperCase();
    if (publicId.isNotEmpty && !_invitePublicIds.contains(publicId)) {
      setState(() {
        _invitePublicIds.add(publicId);
        _publicIdController.clear();
      });
    }
  }

  void _removePublicId(String publicId) {
    setState(() {
      _invitePublicIds.remove(publicId);
    });
  }

  void _addEmail() {
    final email = _emailController.text.trim().toLowerCase();
    if (email.isNotEmpty && _isValidEmail(email) && !_inviteEmails.contains(email)) {
      setState(() {
        _inviteEmails.add(email);
        _emailController.clear();
      });
    }
  }

  void _removeEmail(String email) {
    setState(() {
      _inviteEmails.remove(email);
    });
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          // If start date is after end date, adjust end date
          if (_startDate.isAfter(_endDate)) {
            _endDate = _startDate.add(const Duration(days: 1));
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _createTrip() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement API call to create trip
      final tripData = {
        'title': _titleController.text.trim(),
        'destination': _destinationController.text.trim(),
        'startDate': _startDate.toIso8601String(),
        'endDate': _endDate.toIso8601String(),
        'invitePublicIds': _invitePublicIds,
        'inviteEmails': _inviteEmails,
      };
      
      print('Creating trip with data: $tripData');
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Trip created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Reset form
      _formKey.currentState!.reset();
      _titleController.clear();
      _destinationController.clear();
      setState(() {
        _startDate = DateTime.now();
        _endDate = DateTime.now().add(const Duration(days: 1));
        _invitePublicIds.clear();
        _inviteEmails.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color scaffold = const Color(0xFFF4F5F7);
    final Color onBackground = const Color(0xFF111827);
    final Color card = Colors.white;
    final Color accent = const Color(0xFF0EA5E9);

    return Scaffold(
      backgroundColor: scaffold,
      body: SafeArea(
        child: Column(
          children: [
            // Top header with SOS and Profile
            TopHeaderWidget(onBackground: onBackground),
            
            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Trip Title
                      _buildSectionTitle('Trip Details', onBackground),
                      const SizedBox(height: 16),
                      _buildCard(
                        card,
                        child: Column(
                          children: [
                            _buildTextField(
                              controller: _titleController,
                              label: 'Trip Title',
                              hint: 'Enter trip title',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Trip title is required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              controller: _destinationController,
                              label: 'Destination',
                              hint: 'Enter destination',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Destination is required';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Dates
                      _buildSectionTitle('Trip Dates', onBackground),
                      const SizedBox(height: 16),
                      _buildCard(
                        card,
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildDateField(
                                'Start Date',
                                _startDate,
                                () => _selectDate(context, true),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildDateField(
                                'End Date',
                                _endDate,
                                () => _selectDate(context, false),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Invite Public IDs
                      _buildSectionTitle('Invite by Public ID', onBackground),
                      const SizedBox(height: 16),
                      _buildCard(
                        card,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    controller: _publicIdController,
                                    label: 'Public ID',
                                    hint: 'Enter public ID',
                                  ),
                                ),
                                const SizedBox(width: 12),
                                _buildAddButton(_addPublicId, accent),
                              ],
                            ),
                            if (_invitePublicIds.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              _buildInviteList(_invitePublicIds, _removePublicId, accent),
                            ],
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Invite Emails
                      _buildSectionTitle('Invite by Email', onBackground),
                      const SizedBox(height: 16),
                      _buildCard(
                        card,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    controller: _emailController,
                                    label: 'Email',
                                    hint: 'Enter email address',
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                _buildAddButton(_addEmail, accent),
                              ],
                            ),
                            if (_inviteEmails.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              _buildInviteList(_inviteEmails, _removeEmail, accent),
                            ],
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Create Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _createTrip,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accent,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Create Trip',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildCard(Color cardColor, {required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF0EA5E9)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildDateField(String label, DateTime date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${date.day}/${date.month}/${date.year}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(VoidCallback onPressed, Color color) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.add, color: color),
      ),
    );
  }

  Widget _buildInviteList(List<String> items, Function(String) onRemove, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Added (${items.length}):',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => onRemove(item),
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: color,
                  ),
                ),
              ],
            ),
          )).toList(),
        ),
      ],
    );
  }
}
