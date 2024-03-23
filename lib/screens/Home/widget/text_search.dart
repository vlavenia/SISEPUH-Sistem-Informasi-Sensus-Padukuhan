import 'package:flutter/material.dart';
import 'package:sisepuh/screens/mastertable/widget/streambuilder_data.dart';

class TextSearchField extends StatelessWidget {
  TextSearchField({
    super.key,
  });
  var keyword = Streambuilderdata(
    refreshCallback: () {},
  );
  var keywordSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 12.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: Colors.grey[500],
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: keyword.keywordSearchC,
              initialValue: null,
              decoration: InputDecoration.collapsed(
                filled: true,
                fillColor: Colors.transparent,
                hintText: "Search data",
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                ),
                hoverColor: Colors.transparent,
              ), //testing
              onFieldSubmitted: (value) {
                keywordSearch = value;
                print("##[TextSearch] keyword yang didapat : $keywordSearch");
                print(
                    "##[TextSearch] keyword yang didapat dri c : ${keyword.keywordSearchC.text}");
                keyword.build(context);
                keyword.refreshCallback();
              },
            ),
          ),
        ],
      ),
    );
  }
}
