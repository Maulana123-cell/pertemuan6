import 'package:flutter/material.dart';

class RadiobuttonPage extends StatefulWidget {
  const RadiobuttonPage({super.key});

  @override
  _RadiobuttonPageState createState() => _RadiobuttonPageState();
}

class _RadiobuttonPageState extends State<RadiobuttonPage> {

  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _umurController = TextEditingController();

  String? _selectedGender;
  String? _selectedJob;
  String? _selectedWorkType;
  String? _selectedSize;
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        title: const Text("Form Radio Button"),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00695C), Color(0xFF26A69A)],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              // ================= CARD DATA =================
              _buildCard(
                title: "Data Diri",
                icon: Icons.person,
                child: Column(
                  children: [
                    _inputField(_namaController, "Nama"),
                    const SizedBox(height: 12),
                    _inputField(_umurController, "Umur", isNumber: true),
                  ],
                ),
              ),

              // ================= GENDER =================
              _buildCard(
                title: "Jenis Kelamin",
                icon: Icons.people,
                child: Row(
                  children: [
                    Expanded(child: _radioCard("Laki-laki", Icons.male, Colors.blue)),
                    const SizedBox(width: 10),
                    Expanded(child: _radioCard("Perempuan", Icons.female, Colors.pink)),
                  ],
                ),
              ),

              // ================= PEKERJAAN =================
              _buildCard(
                title: "Pekerjaan",
                icon: Icons.work,
                child: Wrap(
                  spacing: 10,
                  children: ["Admin", "Guru", "Programmer"].map((job) {
                    return ChoiceChip(
                      label: Text(job),
                      selected: _selectedJob == job,
                      onSelected: (val) {
                        setState(() {
                          _selectedJob = val ? job : null;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),

              // ================= TIPE =================
              _buildCard(
                title: "Tipe Pekerjaan",
                icon: Icons.business_center,
                child: Column(
                  children: ["Full Time", "Part Time", "Freelance"].map((type) {
                    return RadioListTile(
                      title: Text(type),
                      value: type,
                      groupValue: _selectedWorkType,
                      onChanged: (val) {
                        setState(() {
                          _selectedWorkType = val.toString();
                        });
                      },
                    );
                  }).toList(),
                ),
              ),

              // ================= HORIZONTAL =================
              _buildCard(
                title: "Ukuran",
                icon: Icons.straighten,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ["S", "M", "L"].map((size) {
                    return Column(
                      children: [
                        Radio(
                          value: size,
                          groupValue: _selectedSize,
                          onChanged: (val) {
                            setState(() {
                              _selectedSize = val.toString();
                            });
                          },
                        ),
                        Text(size),
                      ],
                    );
                  }).toList(),
                ),
              ),

              // ================= TOGGLE =================
              _buildCard(
                title: "Pilihan",
                icon: Icons.toggle_on,
                child: Column(
                  children: ["A", "B"].map((opt) {
                    return RadioListTile(
                      title: Text("Option $opt"),
                      value: opt,
                      groupValue: _selectedOption,
                      toggleable: true,
                      onChanged: (val) {
                        setState(() {
                          _selectedOption = val?.toString();
                        });
                      },
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),

              // ================= BUTTON =================
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.teal,
                      ),
                      onPressed: _submit,
                      child: const Text("Submit"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _reset,
                      child: const Text("Reset"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // ================= WIDGET =================

  Widget _buildCard({required String title, required IconData icon, required Widget child}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.teal),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _inputField(TextEditingController controller, String label, {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (val) => val!.isEmpty ? "$label wajib diisi" : null,
    );
  }

  Widget _radioCard(String text, IconData icon, Color color) {
    bool selected = _selectedGender == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.2) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            Text(text),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text("Hasil"),
          content: Text(
            "Nama: ${_namaController.text}\n"
            "Umur: ${_umurController.text}\n"
            "Gender: $_selectedGender\n"
            "Pekerjaan: $_selectedJob\n"
            "Tipe: $_selectedWorkType\n"
            "Ukuran: $_selectedSize\n"
            "Pilihan: $_selectedOption",
          ),
        ),
      );
    }
  }

  void _reset() {
    _formKey.currentState!.reset();
    _namaController.clear();
    _umurController.clear();

    setState(() {
      _selectedGender = null;
      _selectedJob = null;
      _selectedWorkType = null;
      _selectedSize = null;
      _selectedOption = null;
    });
  }
}
