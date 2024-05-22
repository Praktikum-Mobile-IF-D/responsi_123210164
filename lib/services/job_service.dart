import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/job.dart';

class JobService {
  Future<JobData> fetchJobs() async {
    final response = await http.get(Uri.parse('https://jobicy.com/api/v2/remote-jobs'));

    if (response.statusCode == 200) {
      return JobData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}