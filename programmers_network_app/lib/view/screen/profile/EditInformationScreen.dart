import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/profile/profile_cubit.dart';
import '../../../data/models/Profile/profile_model.dart';
import 'EditPhotoScreen.dart';

class EditInformationScreen extends StatefulWidget {
  final ProfileData profileData;

  const EditInformationScreen({Key? key, required this.profileData})
    : super(key: key);

  @override
  State<EditInformationScreen> createState() => _EditInformationScreenState();
}

class _EditInformationScreenState extends State<EditInformationScreen> {
  // Controllers
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _bioController;
  late TextEditingController _universityController;
  late TextEditingController _majorController;
  late TextEditingController _cityController;
  late TextEditingController _titleController;
  late TextEditingController _jobTitleController;
  late TextEditingController _companyController;
  late TextEditingController _experienceController;
  late TextEditingController _githubController;
  late TextEditingController _linkedinController;

  // Dropdown States
  String? _educationStatus;
  String? _studyYear;
  String? _country;

  final Color limeGreen = const Color(0xffB8FF1A);
  final Color grayInactive = const Color(0xFFF1F1EF);

  @override
  void initState() {
    super.initState();
    final data = widget.profileData;
    _nameController = TextEditingController(text: data.fullName);
    _usernameController = TextEditingController(text: data.username);
    _bioController = TextEditingController(text: data.bio);
    _universityController = TextEditingController(text: data.university);
    _majorController = TextEditingController(text: data.major);
    _cityController = TextEditingController(text: data.city);
    _titleController = TextEditingController(text: data.specialization);
    _jobTitleController = TextEditingController(text: data.jobTitle);
    _companyController = TextEditingController(text: data.company);
    _experienceController = TextEditingController(
      text: data.experienceYears?.toString() ?? '0',
    );
    _githubController = TextEditingController(text: data.githubUrl);
    _linkedinController = TextEditingController(text: data.linkedinUrl);

    _educationStatus = data.educationStatus;
    _studyYear = data.studyYear;
    _country = data.country;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _universityController.dispose();
    _majorController.dispose();
    _cityController.dispose();
    _titleController.dispose();
    _jobTitleController.dispose();
    _companyController.dispose();
    _experienceController.dispose();
    _githubController.dispose();
    _linkedinController.dispose();

    super.dispose();
  }

  void _saveAllChanges() {
    context.read<ProfileCubit>().updateProfileData(
      fullName: _nameController.text,
      username: _usernameController.text,
      specialization: _titleController.text,
      bio: _bioController.text,
      city: _cityController.text,
      country: _country ?? widget.profileData.country,

      educationStatus: _educationStatus ?? widget.profileData.educationStatus,
      university: _universityController.text,
      major: _majorController.text.isEmpty ? null : _majorController.text,
      studyYear: _studyYear ?? widget.profileData.studyYear,
      jobTitle: _jobTitleController.text,
      company: _companyController.text.isEmpty ? null : _companyController.text,
      experienceYears: int.tryParse(_experienceController.text) ?? 0,
      githubUrl: _githubController.text.isEmpty ? null : _githubController.text,

      linkedinUrl: _linkedinController.text.isEmpty

          ? null
          : _linkedinController.text,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1FDE1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: const EdgeInsets.only(left: 6),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black54,
                size: 14,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: grayInactive,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (c) => BlocProvider.value(
                              value: context.read<ProfileCubit>(),
                              child: EditPhotoScreen(
                                profileData: widget.profileData,
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Center(
                        child: Text(
                          'Edit Photo',
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: limeGreen,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Center(
                        child: Text(
                          'Edit Information',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _buildSectionCard(
              title: "Basic Information",
              icon: Icons.person_outline,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField('Full Name', _nameController),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField('Username', _usernameController),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTextField('Bio', _bioController, maxLines: 3),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 2. Education Card
            _buildSectionCard(
              title: "Education",
              icon: Icons.school_outlined,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdownField(
                          "Education Status",
                          _educationStatus,
                          ["student", "Graduate"],
                          (val) => setState(() => _educationStatus = val),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(
                          "University",
                          _universityController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField("Major", _majorController),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDropdownField(
                          "Study Year",
                          _studyYear,
                          [
                            "first_year",
                            "second_year",
                            "third_year",
                            "fourth_year",
                          ],
                          (val) => setState(() => _studyYear = val),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildSectionCard(
              title: "Location",
              icon: Icons.location_on_outlined,
              child: Row(
                children: [
                  Expanded(
                    child: _buildDropdownField("Country", _country, [
                      "syria",
                      "Lebanon",
                      "UAE",
                    ], (val) => setState(() => _country = val)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: _buildTextField("City", _cityController)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildSectionCard(
              title: "Professional Information",
              icon: Icons.business_center_outlined,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          'Specialization',
                          _titleController,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(
                          "Job Title",
                          _jobTitleController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField("Company", _companyController),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(
                          "Experience (Years)",
                          _experienceController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField("GitHub URL", _githubController),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(
                          "LinkedIn URL",
                          _linkedinController,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveAllChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: limeGreen,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: Colors.grey.shade700),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const Divider(height: 24, color: Color(0xFFF1FDE1)),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade100, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: limeGreen, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    String? value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: items.contains(value) ? value : null,
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(fontSize: 13)),
                ),
              )
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade100, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: limeGreen, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
