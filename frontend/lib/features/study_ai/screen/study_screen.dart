import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../service/study_api_service.dart';
import '../model/study_model.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {

  final topicController = TextEditingController();
  final questionController = TextEditingController();

  final StudyApiService api = StudyApiService();

  StudyModel? result;
  bool loading = false;
  String? error;

  Future<void> askAI() async {

    setState(() {
      loading = true;
      error = null;
      result = null;
    });

    try {

      final res = await api.askQuestion(
        topic: topicController.text,
        question: questionController.text,
      );

      setState(() {
        result = res;
      });

    } catch (e) {

      setState(() {
        error = e.toString();
      });

    } finally {

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("AI Study Assistant"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            _buildInput(
              controller: topicController,
              hint: "Enter Topic (e.g. Photosynthesis)",
            ),

            const SizedBox(height: 12),

            _buildInput(
              controller: questionController,
              hint: "Ask your question",
              maxLines: 3,
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.all(14),
                ),

                onPressed: loading ? null : askAI,

                child: loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Ask AI"),
              ),
            ),

            const SizedBox(height: 20),

            if (error != null)
              Text(
                error!,
                style: const TextStyle(color: Colors.red),
              ),

            if (result != null)
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: SingleChildScrollView(
                    child: Text(
                      result!.response,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {

    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}