import 'package:flutter/material.dart';

class AutocompletespinPage extends StatefulWidget {
  const AutocompletespinPage({super.key});

  @override
  State<AutocompletespinPage> createState() => _CompleteFormPageState();
}

class _CompleteFormPageState extends State<AutocompletespinPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers untuk Autocomplete
  final TextEditingController _universityController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();

  // Selected values untuk dropdown
  String? _selectedEducationLevel;
  String? _selectedYear;

  // Data options
  final List<String> _universities = [
    'Universitas Indonesia',
    'Institut Teknologi Bandung',
    'Universitas Gadjah Mada',
    'Universitas Padjadjaran',
    'Universitas Airlangga',
    'Institut Pertanian Bogor',
    'Universitas Brawijaya',
    'Universitas Diponegoro',
    'Universitas Sebelas Maret',
    'Universitas Negeri Jakarta',
    'Universitas Pamulang',
  ];

  final List<String> _majors = [
    'Teknik Informatika',
    'Sistem Informasi',
    'Teknik Elektro',
    'Manajemen',
    'Akuntansi',
    'Hukum',
    'Kedokteran',
    'Psikologi',
    'Desain Komunikasi Visual',
    'Hubungan Internasional',
  ];

  final List<String> _educationLevels = [
    'SMA/Sederajat',
    'D3',
    'S1',
    'S2',
    'S3',
  ];

  final List<String> _years = [
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Form dengan AutoComplete dan Spinner',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 8,
          shadowColor: Colors.deepPurple.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Informasi Mahasiswa',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const Divider(height: 32, color: Colors.purple),

                  // Autocomplete Universitas
                  _buildAutocompleteField(
                    label: 'Universitas',
                    controller: _universityController,
                    options: _universities,
                    hint: 'Cari universitas...',
                    icon: Icons.school,
                    onSelected: (value) {
                      setState(() {
                        _universityController.text = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),

                  // Autocomplete Jurusan
                  _buildAutocompleteField(
                    label: 'Jurusan',
                    controller: _majorController,
                    options: _majors,
                    hint: 'Cari jurusan...',
                    icon: Icons.book,
                    onSelected: (value) {
                      setState(() {
                        _majorController.text = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),

                  // Dropdown Jenjang Pendidikan
                  _buildDropdownField(
                    label: 'Jenjang Pendidikan',
                    value: _selectedEducationLevel,
                    items: _educationLevels,
                    hint: 'Pilih jenjang pendidikan',
                    icon: Icons.timeline,
                    onChanged: (value) {
                      setState(() {
                        _selectedEducationLevel = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),

                  // Dropdown Tahun Masuk
                  _buildDropdownField(
                    label: 'Tahun Masuk',
                    value: _selectedYear,
                    items: _years,
                    hint: 'Pilih tahun masuk',
                    icon: Icons.calendar_today,
                    onChanged: (value) {
                      setState(() {
                        _selectedYear = value;
                      });
                    },
                  ),
                  const SizedBox(height: 32),

                  // Tombol Submit
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAutocompleteField({
    required String label,
    required TextEditingController controller,
    required List<String> options,
    required String hint,
    required IconData icon,
    required Function(String) onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.deepPurple),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Autocomplete<String>(
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return options.where((option) => option
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()));
          },
          onSelected: onSelected,
          fieldViewBuilder:
              (context, fieldController, focusNode, onFieldSubmitted) {
            return TextFormField(
              controller: fieldController,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Silakan pilih $label';
                }
                if (!options.contains(value)) {
                  return '$label tidak valid';
                }
                return null;
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required String hint,
    required IconData icon,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: items.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Silakan pilih $label';
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        child: const Text('Simpan Data'),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 10),
              Text(
                'Berhasil!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Data mahasiswa berhasil disimpan:'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(
                        Icons.school, 'Universitas', _universityController.text),
                    const SizedBox(height: 8),
                    _buildDetailRow(
                        Icons.book, 'Jurusan', _majorController.text),
                    const SizedBox(height: 8),
                    _buildDetailRow(Icons.timeline, 'Jenjang',
                        _selectedEducationLevel ?? '-'),
                    const SizedBox(height: 8),
                    _buildDetailRow(Icons.calendar_today, 'Tahun Masuk',
                        _selectedYear ?? '-'),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _resetForm();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.deepPurple,
              ),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.warning, color: Colors.white),
              SizedBox(width: 10),
              Expanded(child: Text('Harap lengkapi semua field yang diperlukan')),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(10),
        ),
      );
    }
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.deepPurple),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _resetForm() {
    setState(() {
      _universityController.clear();
      _majorController.clear();
      _selectedEducationLevel = null;
      _selectedYear = null;
      _formKey.currentState?.reset();
    });
  }

  @override
  void dispose() {
    _universityController.dispose();
    _majorController.dispose();
    super.dispose();
  }
}
