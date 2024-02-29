import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/language_provider.dart';
import '../utiles/custom_appbar.dart';


class CanceledScreen extends StatelessWidget {
  const CanceledScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Stack(
          children: [
            const SizedBox(height: 8),
            SingleChildScrollView(
              child: Column(
                children: [
                  _itemUpdate(),
                  const SizedBox(height: 40)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _itemUpdate() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 10,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (BuildContext context, index) {

          var languageProvider = Provider.of<LanguageProvider>(context);
          var currentLanguage = languageProvider.currentLanguage;

          return Card(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ///title
                        Text(
                          'Navigate highs and lows, turning crises into emotional resilience.',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
            
                        ///sub title
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            'Mauris consectetur tortor ac nulla consequat, sit amet eleifend orci rutrum. Sed pharetra magna ut justo rhoncus feugiat.',
                            style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context).colorScheme.secondary),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            '${currentLanguage.date}: 02/06/2024',
                            style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
            
                        ///now
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.red.shade900,
                            ),
                            child: Text(
                              currentLanguage.cancelled,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSecondary
                                //color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
            
                  ///delete and edit
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.edit_note,
                            color: Colors.green.shade900,
                            size: 20,
                          ),
                          Icon(
                            Icons.delete,
                            color: Colors.red.shade900,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}