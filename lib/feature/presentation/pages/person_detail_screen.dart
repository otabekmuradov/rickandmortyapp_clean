// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:rickandmortyapp/feature/domain/entities/person_entity.dart';
import 'package:rickandmortyapp/feature/presentation/widgets/person_cache_image_widget.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;
  const PersonDetailPage({
    Key? key,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Character'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              person.name,
              style: const TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Container(
              child: PersonCacheImage(
                imageUrl: person.image,
                width: 220,
                height: 220,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: person.status == 'Alive'
                              ? Colors.green
                              : Colors.red),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      person.status,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    if (person.type.isNotEmpty)
                      ...buildText('Type : ', person.type),
                    const SizedBox(height: 12),
                    ...buildText('Gender :', person.gender),
                    const SizedBox(height: 12),
                    ...buildText('Number of episodes :',
                        person.episode.length.toString()),
                    const SizedBox(height: 12),
                    ...buildText('Species :', person.species),
                    const SizedBox(height: 12),
                    ...buildText(
                        'Last known location :', person.location!.name),
                    const SizedBox(height: 12),
                    ...buildText('Origin :', person.origin!.name),
                    const SizedBox(height: 12),
                    ...buildText(
                        'Was created :', person.created.toIso8601String()),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildText(String text, String value) {
    return [
      Text(
        text,
        style: TextStyle(fontSize: 18, color: Colors.grey[400]),
      ),
      const SizedBox(height: 8),
      Text(
        value,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
      ),
    ];
  }
}
