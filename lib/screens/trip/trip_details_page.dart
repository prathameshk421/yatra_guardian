import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/trip_model.dart';
import '../../theme/app_colors.dart';
import '../../services/trip_service.dart';

class TripDetailsPage extends StatefulWidget {
  final Trip trip;

  const TripDetailsPage({
    super.key,
    required this.trip,
  });

  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  late Trip _trip;
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _destinationController;
  late TextEditingController _groupIdController;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _trip = widget.trip;
    _titleController = TextEditingController(text: _trip.title);
    _destinationController = TextEditingController(text: _trip.destination);
    _groupIdController = TextEditingController(text: _trip.groupId ?? '');
    _startDate = _trip.startDate;
    _endDate = _trip.endDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _destinationController.dispose();
    _groupIdController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // Reset to original values if canceling edit
        _titleController.text = _trip.title;
        _destinationController.text = _trip.destination;
        _groupIdController.text = _trip.groupId ?? '';
        _startDate = _trip.startDate;
        _endDate = _trip.endDate;
      }
    });
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;
    if (_startDate == null || _endDate == null) return;

    try {
      // Here you would typically call your API to update the trip
      // For now, we'll just update the local state
      setState(() {
        _trip = _trip.copyWith(
          title: _titleController.text,
          destination: _destinationController.text,
          startDate: _startDate!,
          endDate: _endDate!,
          groupId: _groupIdController.text.isEmpty ? null : _groupIdController.text,
        );
        _isEditing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Trip updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating trip: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _copyTripIdToClipboard() {
    Clipboard.setData(ClipboardData(text: _trip.id));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Trip ID copied to clipboard'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate! : _endDate!,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: AppColors.scaffold,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.onBackground),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Trip Details',
          style: TextStyle(
            color: AppColors.onBackground,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          if (_trip.isEditable)
            IconButton(
              icon: Icon(
                _isEditing ? Icons.close : Icons.edit,
                color: AppColors.accent,
              ),
              onPressed: _isEditing ? _toggleEdit : _toggleEdit,
            ),
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.save, color: AppColors.accent),
              onPressed: _saveChanges,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TripHeaderCard(trip: _trip),
              const SizedBox(height: 20),
              _TripInfoCard(
                trip: _trip,
                isEditing: _isEditing,
                titleController: _titleController,
                destinationController: _destinationController,
                groupIdController: _groupIdController,
                startDate: _startDate,
                endDate: _endDate,
                onDateSelected: _selectDate,
              ),
              const SizedBox(height: 20),
              _JoinedUsersCard(trip: _trip, isEditing: _isEditing),
              const SizedBox(height: 20),
              _EventsCard(trip: _trip, isEditing: _isEditing),
            ],
          ),
        ),
      ),
    );
  }
}

class _TripHeaderCard extends StatelessWidget {
  final Trip trip;

  const _TripHeaderCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: trip.imageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(trip.imageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: trip.imageUrl == null ? AppColors.accent.withOpacity(0.1) : null,
                ),
                child: trip.imageUrl == null
                    ? Icon(
                        Icons.trip_origin_rounded,
                        color: AppColors.accent,
                        size: 30,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.title,
                      style: const TextStyle(
                        color: AppColors.onBackground,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      trip.destination,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor(trip.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        trip.status.toUpperCase(),
                        style: TextStyle(
                          color: _getStatusColor(trip.status),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _InfoItem(
                  icon: Icons.fingerprint,
                  label: 'Trip ID',
                  value: trip.id,
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: trip.id));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Trip ID copied to clipboard'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                ),
              ),
              if (trip.groupId != null) ...[
                const SizedBox(width: 16),
                Expanded(
                  child: _InfoItem(
                    icon: Icons.group,
                    label: 'Group ID',
                    value: trip.groupId!,
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: trip.groupId!));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Group ID copied to clipboard'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return Colors.green;
      case 'upcoming':
        return Colors.orange;
      case 'completed':
        return Colors.blue;
      default:
        return AppColors.muted;
    }
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.scaffold,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.accent, size: 16),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: AppColors.onBackground,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _TripInfoCard extends StatelessWidget {
  final Trip trip;
  final bool isEditing;
  final TextEditingController titleController;
  final TextEditingController destinationController;
  final TextEditingController groupIdController;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(BuildContext, bool) onDateSelected;

  const _TripInfoCard({
    required this.trip,
    required this.isEditing,
    required this.titleController,
    required this.destinationController,
    required this.groupIdController,
    required this.startDate,
    required this.endDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trip Information',
            style: TextStyle(
              color: AppColors.onBackground,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          _EditableField(
            label: 'Title',
            controller: titleController,
            isEditing: isEditing,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _EditableField(
            label: 'Destination',
            controller: destinationController,
            isEditing: isEditing,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a destination';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _EditableField(
            label: 'Group ID (Optional)',
            controller: groupIdController,
            isEditing: isEditing,
            hintText: 'Enter group ID if applicable',
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _DateField(
                  label: 'Start Date',
                  date: startDate,
                  isEditing: isEditing,
                  onTap: () => onDateSelected(context, true),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _DateField(
                  label: 'End Date',
                  date: endDate,
                  isEditing: isEditing,
                  onTap: () => onDateSelected(context, false),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EditableField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isEditing;
  final String? Function(String?)? validator;
  final String? hintText;

  const _EditableField({
    required this.label,
    required this.controller,
    required this.isEditing,
    this.validator,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        isEditing
            ? TextFormField(
                controller: controller,
                validator: validator,
                decoration: InputDecoration(
                  hintText: hintText ?? 'Enter $label',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.muted),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.muted),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.accent),
                  ),
                ),
              )
            : Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.scaffold,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  controller.text.isEmpty ? 'Not specified' : controller.text,
                  style: const TextStyle(
                    color: AppColors.onBackground,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
      ],
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final bool isEditing;
  final VoidCallback onTap;

  const _DateField({
    required this.label,
    required this.date,
    required this.isEditing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: isEditing ? onTap : null,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.scaffold,
              borderRadius: BorderRadius.circular(8),
              border: isEditing
                  ? Border.all(color: AppColors.muted)
                  : null,
            ),
            child: Text(
              date != null
                  ? '${date!.day}/${date!.month}/${date!.year}'
                  : 'Select date',
              style: TextStyle(
                color: date != null ? AppColors.onBackground : AppColors.muted,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _JoinedUsersCard extends StatelessWidget {
  final Trip trip;
  final bool isEditing;

  const _JoinedUsersCard({
    required this.trip,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.people, color: AppColors.accent, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Joined Users',
                style: TextStyle(
                  color: AppColors.onBackground,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '${trip.joinedUsers.length}',
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (trip.joinedUsers.isEmpty)
            const Text(
              'No users joined yet',
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 14,
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: trip.joinedUsers.map((user) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    user,
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class _EventsCard extends StatelessWidget {
  final Trip trip;
  final bool isEditing;

  const _EventsCard({
    required this.trip,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.event, color: AppColors.accent, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Events',
                style: TextStyle(
                  color: AppColors.onBackground,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                '${trip.events.length}',
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (trip.events.isEmpty)
            const Text(
              'No events scheduled',
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 14,
              ),
            )
          else
            Column(
              children: trip.events.map((event) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _EventItem(event: event),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class _EventItem extends StatelessWidget {
  final TripEvent event;

  const _EventItem({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.scaffold,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.muted.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getEventIcon(event.type),
                  color: AppColors.accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  event.type,
                  style: const TextStyle(
                    color: AppColors.onBackground,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '${event.time.hour.toString().padLeft(2, '0')}:${event.time.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            event.location,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (event.description != null) ...[
            const SizedBox(height: 4),
            Text(
              event.description!,
              style: const TextStyle(
                color: AppColors.onBackground,
                fontSize: 13,
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _getEventIcon(String type) {
    switch (type.toLowerCase()) {
      case 'check-in':
        return Icons.login;
      case 'check-out':
        return Icons.logout;
      case 'meal':
        return Icons.restaurant;
      case 'activity':
        return Icons.sports;
      case 'transport':
        return Icons.directions;
      default:
        return Icons.event;
    }
  }
}
