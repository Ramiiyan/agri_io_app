import 'package:flutter/material.dart';
import 'internalClass.dart';

class CardSample2 extends StatelessWidget {
  const CardSample2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 25),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Sensor Name",
                          style: MyTextSample.title(context)!
                              .copyWith(color: MyColorsSample.grey_80)),
                    ),
                    Text(
                      "Sensor Type",
                      style: MyTextSample.body1(context)!.copyWith(
                        color: Colors.grey[500],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("100 %",
                            style: MyTextSample.display1(context)!.copyWith(
                                color: const Color.fromARGB(255, 0, 0, 0))),
                        Expanded(
                          flex: 0,
                          child: Image.asset(
                            ImgSample.get("soli.png"),
                            height: 80,
                            width: 80,
                            // fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),

                    // Text("Sensor Name",
                    //     style: MyTextSample.title(context)!
                    //         .copyWith(color: MyColorsSample.grey_80)),
                    // Image.asset(
                    //   ImgSample.get("relaxing_man.jpeg"),
                    //   height: 100,
                    //   width: 100,
                    //   fit: BoxFit.cover,
                    // ),
                    // Container(width: 20),
                    // Image.asset(
                    //   ImgSample.get("relaxing_man.jpeg"),
                    //   height: 100,
                    //   width: 100,
                    //   fit: BoxFit.cover,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
    // TODO: implement build
    throw UnimplementedError();
  }

  Widget CardWidget() {
    return const Card();
  }
}
