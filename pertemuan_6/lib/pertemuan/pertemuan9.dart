import 'package:flutter/material.dart';

class Pertemuan9Page extends StatefulWidget {
  const Pertemuan9Page({super.key});

  @override
  State<Pertemuan9Page> createState() => _Pertemuan9PageState();
}

class _Pertemuan9PageState extends State<Pertemuan9Page> {
  final Color primaryColor = const Color(0xFF5B50E8);

  final TextEditingController _judulController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  DateTime? startDate;
  DateTime? endDate;

  DateTime? selectedDateTime;
  TimeOfDay? selectedDateTimeTime;

  @override
  void dispose() {
    _judulController.dispose();
    super.dispose();
  }

  String formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  Future<void> _pickDate({
    required Function(DateTime) onPicked,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onPicked(picked);
    }
  }

  Future<void> _pickTime({
    required Function(TimeOfDay) onPicked,
  }) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onPicked(picked);
    }
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 4),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade500,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildFieldRow({
    required IconData icon,
    required String label,
    required String? value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                value ?? label,
                style: TextStyle(
                  fontSize: 14,
                  color: value != null
                      ? Colors.black87
                      : Colors.grey.shade400,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldRowInGroup({
    required IconData icon,
    required String label,
    required String? value,
    required VoidCallback onTap,
    required bool showDivider,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    value ?? label,
                    style: TextStyle(
                      fontSize: 14,
                      color: value != null
                          ? Colors.black87
                          : Colors.grey.shade400,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: Colors.grey.shade200,
            indent: 14,
            endIndent: 14,
          ),
      ],
    );
  }

  void _simpan() {
    if (_judulController.text.isEmpty &&
        selectedDate == null &&
        selectedTime == null &&
        startDate == null &&
        endDate == null &&
        selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Isi data terlebih dahulu'),
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Preview Data',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 12),

              if (_judulController.text.isNotEmpty)
                _previewRow(
                  Icons.title,
                  'Judul',
                  _judulController.text,
                ),

              if (selectedDate != null)
                _previewRow(
                  Icons.calendar_today,
                  'Tanggal',
                  formatDate(selectedDate!),
                ),

              if (selectedTime != null)
                _previewRow(
                  Icons.access_time,
                  'Waktu',
                  formatTime(selectedTime!),
                ),

              if (startDate != null)
                _previewRow(
                  Icons.calendar_month,
                  'Mulai',
                  formatDate(startDate!),
                ),

              if (endDate != null)
                _previewRow(
                  Icons.event_available,
                  'Selesai',
                  formatDate(endDate!),
                ),

              if (selectedDateTime != null)
                _previewRow(
                  Icons.event,
                  'Tgl & Waktu',
                  '${formatDate(selectedDateTime!)}'
                      '${selectedDateTimeTime != null ? ', ${formatTime(selectedDateTimeTime!)}' : ''}',
                ),

              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _previewRow(
    IconData icon,
    String key,
    String val,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            '$key: ',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          Expanded(
            child: Text(
              val,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EEF8),

      appBar: AppBar(
        title: const Text(
          'Pertemuan 9',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _buildSectionLabel('INFORMASI ACARA'),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: TextField(
                controller: _judulController,
                decoration: InputDecoration(
                  hintText: 'Judul Acara',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.text_fields,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            _buildSectionLabel('PILIH TANGGAL'),

            _buildFieldRow(
              icon: Icons.calendar_today,
              label: 'Tanggal',
              value: selectedDate != null
                  ? formatDate(selectedDate!)
                  : null,
              onTap: () {
                _pickDate(
                  onPicked: (d) {
                    setState(() {
                      selectedDate = d;
                    });
                  },
                );
              },
            ),

            _buildSectionLabel('PILIH WAKTU'),

            _buildFieldRow(
              icon: Icons.access_time,
              label: 'Waktu',
              value: selectedTime != null
                  ? formatTime(selectedTime!)
                  : null,
              onTap: () {
                _pickTime(
                  onPicked: (t) {
                    setState(() {
                      selectedTime = t;
                    });
                  },
                );
              },
            ),

            _buildSectionLabel('RENTANG TANGGAL'),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: Column(
                children: [
                  _buildFieldRowInGroup(
                    icon: Icons.calendar_month,
                    label: 'Tanggal Mulai',
                    value: startDate != null
                        ? formatDate(startDate!)
                        : null,
                    onTap: () {
                      _pickDate(
                        onPicked: (d) {
                          setState(() {
                            startDate = d;
                          });
                        },
                      );
                    },
                    showDivider: true,
                  ),

                  _buildFieldRowInGroup(
                    icon: Icons.event_available,
                    label: 'Tanggal Selesai',
                    value: endDate != null
                        ? formatDate(endDate!)
                        : null,
                    onTap: () {
                      _pickDate(
                        onPicked: (d) {
                          if (startDate != null &&
                              d.isBefore(startDate!)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Tanggal selesai tidak boleh sebelum tanggal mulai',
                                ),
                              ),
                            );
                            return;
                          }

                          setState(() {
                            endDate = d;
                          });
                        },
                      );
                    },
                    showDivider: false,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            _buildSectionLabel('TANGGAL & WAKTU SEKALIGUS'),

            _buildFieldRow(
              icon: Icons.event,
              label: 'Tanggal & Waktu',
              value: selectedDateTime != null
                  ? '${formatDate(selectedDateTime!)}'
                      '${selectedDateTimeTime != null ? ', ${formatTime(selectedDateTimeTime!)}' : ''}'
                  : null,
              onTap: () async {
                await _pickDate(
                  onPicked: (d) async {
                    setState(() {
                      selectedDateTime = d;
                    });

                    await _pickTime(
                      onPicked: (t) {
                        setState(() {
                          selectedDateTimeTime = t;
                        });
                      },
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 70),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: ElevatedButton.icon(
          onPressed: _simpan,
          icon: const Icon(
            Icons.save,
            color: Colors.white,
          ),
          label: const Text(
            'Simpan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            minimumSize: const Size(
              double.infinity,
              50,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    );
  }
}
