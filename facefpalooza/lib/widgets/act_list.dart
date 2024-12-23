import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/act.dart';

class ActList extends StatelessWidget {
  const ActList({super.key});

  final data = lineup;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('acts')
            .orderBy('day')
            .orderBy('relevance') // Adicione a ordenação por 'relevance'
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var list = snapshot.data?.docs ?? [];

          return ListView(
              children: list.map<Widget>((act) {
            return ListTile(
                title: Text(act['name'], 
                   style: TextStyle(
                    fontWeight: FontWeight.bold, // Negrito
                    fontSize: 20, // Fonte maior
                  ),
                ),
                trailing: CircleAvatar(child: Text("${act['day']}")), // Adicionando o componente trailing para alterar a posição
                subtitle: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: act['tags']
                        .map<Widget>((tag) => Chip(
                          label: Text("#$tag"), 
                          backgroundColor: Colors.deepOrange))
                        .toList()));
          }).toList());
        });
  }
}
