import 'package:flutter/material.dart';
import '../helper/database_helper.dart';
import '../models/job.dart';

class JobDetailScreen extends StatelessWidget {
  final Jobs job;

  JobDetailScreen({required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job.jobTitle ?? 'Job Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (job.companyLogo != null)
                Image.network(job.companyLogo!),
              Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.work),
                  title: Text(job.jobTitle ?? '', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                  subtitle: Text(job.companyName ?? '', style: TextStyle(fontSize: 20.0, color: Colors.grey[700])),
                ),
              ),
              Divider(),
              Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.description),
                  title: Text('Job Description'),
                  subtitle: Text(job.jobDescription ?? '', style: TextStyle(fontSize: 16.0, color: Colors.grey[600])),
                ),
              ),
              Divider(),
              Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Job Location'),
                  subtitle: Text(job.jobGeo ?? '', style: TextStyle(fontSize: 16.0, color: Colors.grey[600])),
                ),
              ),
              Divider(),
              Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.business),
                  title: Text('Job Industry'),
                  subtitle: Text(job.jobIndustry?.join(', ') ?? '', style: TextStyle(fontSize: 16.0, color: Colors.grey[600])),
                ),
              ),
              Divider(),
              Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.attach_money),
                  title: Text('Salary Range'),
                  subtitle: Text('${job.annualSalaryMin} - ${job.annualSalaryMax} ${job.salaryCurrency}', style: TextStyle(fontSize: 16.0, color: Colors.grey[600])),
                ),
              ),
              // Add more cards for other job details
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.bookmark_border),
        onPressed: () async {
          await DatabaseHelper.instance.insertJob(job);
        },
      ),
    );
  }
}