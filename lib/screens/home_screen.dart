import 'package:flutter/material.dart';
import 'package:responsi_123210164/screens/profile_page.dart';
import '../helper/database_helper.dart';
import '../services/job_service.dart';
import '../models/job.dart';
import '../screens/job_detail_screen.dart';

enum Page { home, bookmark, profile }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<JobData> futureJobs;
  Page _currentPage = Page.home;

  @override
  void initState() {
    super.initState();
    fetchJobs();
  }

  fetchJobs() async {
    try {
      futureJobs = JobService().fetchJobs();
    } catch (e) {
      print('Error fetching jobs: $e');
    }
  }

  void _navigateToPage(int index) {
    setState(() {
      _currentPage = Page.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _buildCurrentPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage.index,
        onTap: _navigateToPage,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentPage) {
      case Page.home:
        return _buildHome();
      case Page.bookmark:
        return FutureBuilder<List<Jobs>>(
          future: DatabaseHelper.instance.getJobs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final job = snapshot.data![index];
                  return ListTile(
                    title: Text(job.jobTitle ?? ''),
                    subtitle: Text(job.companyName ?? ''),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        );
      case Page.profile:
        return ProfilePage();
      default:
        return _buildHome();
    }
  }

  Widget _buildHome() {
    return Center(
      child: FutureBuilder<JobData>(
        future: futureJobs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: snapshot.data!.jobs!.length,
              itemBuilder: (context, index) {
                final job = snapshot.data!.jobs![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobDetailScreen(job: job),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (job.companyLogo != null) ...[
                            Center(
                              child: Image.network(
                                job.companyLogo!,
                                width: 100, // Adjust the size of the image
                                height: 100, // Adjust the size of the image
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 16.0),
                          ],
                          Text(
                            job.jobTitle!,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '${job.annualSalaryMin} - ${job.annualSalaryMax}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            job.jobType!.join(', '),
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '${job.companyName}, ${job.jobGeo}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}