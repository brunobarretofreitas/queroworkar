import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

import '../models/job_detail_model.dart';
import '../repositoires/job_repository.dart';

class DetailScreen extends StatelessWidget {
  final jobRepository = JobsRepository();

  final String jobTitle;
  final String jobUrl;

  DetailScreen({
    @required this.jobTitle,
    @required this.jobUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(jobTitle),
      ),
      body: FutureBuilder(
          future: jobRepository.getJobDetail(jobUrl),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final JobDetail jobDetail = snapshot.data;

              return Container(
                child: SingleChildScrollView(
                  child: Html(
                    data: jobDetail.description,
                    padding: EdgeInsets.all(8.0),
                  ),
                ),
              );
            }

            return Center(
              child: Loading(
                indicator: BallPulseIndicator(),
                size: 50.0,
                color: Colors.red,
              ),
            );
          }),
    );
  }
}
