import 'package:dashrock/constants/global_constants.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final Color _temaInfo = Colors.orangeAccent;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(children: [
        Container(
          height: 230,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
              color: _temaInfo,
              boxShadow: [
                BoxShadow(
                  color: _temaInfo.withOpacity(0.3),
                  offset: const Offset(-10.0, 0.0),
                  blurRadius: 20.0,
                  spreadRadius: 4.0,
                )
              ]),
          child: Stack(children: [
            Positioned(
              top: 80,
              left: 0,
              child: Container(
                height: 100,
                width: 300,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 115,
              left: 20,
              child: Text(
                "Equipo Rocket",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: _temaInfo,
                ),
              ),
            ),
          ]),
        ),
        SizedBox(height: height * 0.02),
        Container(
          height: 230,
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 20,
                child: Material(
                  child: Container(
                    height: 180,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              offset: const Offset(-10.0, 10.0),
                              blurRadius: 20,
                              spreadRadius: 4),
                        ]),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 30,
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/rocketeam.png"),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 200,
                child: Container(
                  height: 150,
                  width: width * 0.40,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Equipo Rocket",
                          style: TextStyle(
                            fontSize: 20,
                            color: _temaInfo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(color: Colors.black),
                        const Text(
                          "BBVA Hackathon",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: team.length,
              itemBuilder: (BuildContext context, int position) {
                return getRow(position);
              }),
        ),
      ]),
    );
  }

  Widget getRow(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0, top: 0),
      height: 200,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          color: _temaInfo,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(80),
          ),
          boxShadow: [
            BoxShadow(
                color: _temaInfo.withOpacity(0.3),
                offset: const Offset(-10.0, 0.0),
                blurRadius: 20.0,
                spreadRadius: 4.0),
          ],
        ),
        padding: const EdgeInsets.only(left: 32, top: 50, bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              team[index].description!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              team[index].name!,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
