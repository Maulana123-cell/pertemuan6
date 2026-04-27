import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckboxPage extends StatefulWidget {
  @override
  _FormCheckboxExampleState createState() => _FormCheckboxExampleState();
}

class _FormCheckboxExampleState extends State<CheckboxPage> {
  // Form controllers
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _kelasController = TextEditingController();
  
  // Checkbox states
  bool _isCheckedSyarat = false;
  String _errorText = '';
  
  // Hobby checkboxes
  Map<String, bool> _hobbies = {
    'Membaca': false,
    'Olahraga': false,
    'Musik': false,
    'Game': false,
    'Traveling': false,
  };
  
  // Form validation errors
  String _namaError = '';
  String _nimError = '';
  String _kelasError = '';
  String _hobbyError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,
          title: Text(
            'Form dengan Checkbox',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Form Section
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section Title
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Data Diri',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 20),
                        
                        // Field Nama
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade50,
                          ),
                          child: TextField(
                            controller: _namaController,
                            decoration: InputDecoration(
                              labelText: 'Nama Lengkap',
                              hintText: 'Masukkan nama lengkap Anda',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              errorText: _namaError.isNotEmpty ? _namaError : null,
                              prefixIcon: Icon(Icons.person_outline, color: Colors.blue.shade600),
                              labelStyle: TextStyle(color: Colors.grey.shade700),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 16),
                        
                        // Field NIM
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade50,
                          ),
                          child: TextField(
                            controller: _nimController,
                            decoration: InputDecoration(
                              labelText: 'NIM',
                              hintText: 'Masukkan NIM Anda',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              errorText: _nimError.isNotEmpty ? _nimError : null,
                              prefixIcon: Icon(Icons.numbers, color: Colors.blue.shade600),
                              labelStyle: TextStyle(color: Colors.grey.shade700),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        
                        SizedBox(height: 16),
                        
                        // Field Kelas
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade50,
                          ),
                          child: TextField(
                            controller: _kelasController,
                            decoration: InputDecoration(
                              labelText: 'Kelas',
                              hintText: 'Contoh: 01SIFP001',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              errorText: _kelasError.isNotEmpty ? _kelasError : null,
                              prefixIcon: Icon(Icons.class_, color: Colors.blue.shade600),
                              labelStyle: TextStyle(color: Colors.grey.shade700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
                
                // Hobi Section
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.orange.shade600,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Hobi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '(Pilih minimal 1)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 16),
                        
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey.shade50,
                          ),
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            physics: NeverScrollableScrollPhysics(),
                            childAspectRatio: 3,
                            children: _hobbies.keys.map((hobby) {
                              return CheckboxListTile(
                                title: Text(
                                  hobby,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                value: _hobbies[hobby],
                                onChanged: (bool? value) {
                                  setState(() {
                                    _hobbies[hobby] = value ?? false;
                                    if (_hobbies.values.any((selected) => selected)) {
                                      _hobbyError = '';
                                    }
                                  });
                                },
                                activeColor: Colors.orange.shade600,
                                checkColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                dense: false,
                                controlAffinity: ListTileControlAffinity.leading,
                              );
                            }).toList(),
                          ),
                        ),
                        
                        if (_hobbyError.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(left: 16, top: 8),
                            child: Row(
                              children: [
                                Icon(Icons.warning, size: 16, color: Colors.red),
                                SizedBox(width: 4),
                                Text(
                                  _hobbyError,
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
                
                // Syarat dan Ketentuan
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: Text(
                            'Saya menyetujui syarat dan ketentuan yang berlaku',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          value: _isCheckedSyarat,
                          onChanged: (bool? value) {
                            setState(() {
                              _isCheckedSyarat = value ?? false;
                              if (_isCheckedSyarat) {
                                _errorText = '';
                              }
                            });
                          },
                          activeColor: Colors.green,
                          checkColor: Colors.white,
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                        ),
                        if (_errorText.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(left: 16, bottom: 8),
                            child: Row(
                              children: [
                                Icon(Icons.warning, size: 16, color: Colors.red),
                                SizedBox(width: 4),
                                Text(
                                  _errorText,
                                  style: TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 24),
                
                // Submit Button
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _validateAndSubmit(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'DAFTAR SEKARANG',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                  ),
                ),
                
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
  }
  
  void _validateAndSubmit(BuildContext context) {
    setState(() {
      // Reset errors
      _namaError = '';
      _nimError = '';
      _kelasError = '';
      _hobbyError = '';
      _errorText = '';
      
      // Validate Nama
      if (_namaController.text.trim().isEmpty) {
        _namaError = 'Nama tidak boleh kosong';
      }
      
      // Validate NIM
      if (_nimController.text.trim().isEmpty) {
        _nimError = 'NIM tidak boleh kosong';
      } else if (_nimController.text.trim().length < 8) {
        _nimError = 'NIM minimal 8 karakter';
      }
      
      // Validate Kelas
      if (_kelasController.text.trim().isEmpty) {
        _kelasError = 'Kelas tidak boleh kosong';
      }
      
      // Validate Hobby (minimal 1 dipilih)
      if (!_hobbies.values.any((selected) => selected)) {
        _hobbyError = 'Pilih minimal 1 hobi';
      }
      
      // Validate Terms
      if (!_isCheckedSyarat) {
        _errorText = 'Anda harus menyetujui syarat dan ketentuan';
      }
      
      // If all validations pass
      if (_namaError.isEmpty && 
          _nimError.isEmpty && 
          _kelasError.isEmpty && 
          _hobbyError.isEmpty && 
          _isCheckedSyarat) {
        
        // Get selected hobbies
        List<String> selectedHobbies = _hobbies.keys
            .where((hobby) => _hobbies[hobby] == true)
            .toList();
        
        // Show success dialog
        showDialog(
          context: context,
          builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle,
                      size: 64,
                      color: Colors.green.shade600,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Pendaftaran Berhasil!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 16),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(Icons.person, 'Nama', _namaController.text),
                        SizedBox(height: 12),
                        _buildInfoRow(Icons.numbers, 'NIM', _nimController.text),
                        SizedBox(height: 12),
                        _buildInfoRow(Icons.class_, 'Kelas', _kelasController.text),
                        SizedBox(height: 12),
                        _buildInfoRow(Icons.favorite, 'Hobi', selectedHobbies.join(', ')),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _resetForm();
                      Fluttertoast.showToast(
                        msg: 'Pendaftaran Berhasil Disimpan!!',
                        gravity: ToastGravity.TOP);
                    },
                    child: Text('OK', style: TextStyle(fontSize: 16, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 45),
                      backgroundColor: Colors.blue.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
  
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.blue.shade600),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  void _resetForm() {
    setState(() {
      _namaController.clear();
      _nimController.clear();
      _kelasController.clear();
      _hobbies.updateAll((key, value) => false);
      _isCheckedSyarat = false;
      _namaError = '';
      _nimError = '';
      _kelasError = '';
      _hobbyError = '';
      _errorText = '';
    });
  }
  
  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _kelasController.dispose();
    super.dispose();
  }
}