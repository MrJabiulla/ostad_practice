import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/data/services/network_caller.dart';
import 'package:untitled/data/utility/app_url.dart';
import 'package:untitled/presentation/utiles/card_item_widget.dart';
import 'package:untitled/presentation/utiles/custom_snackbar.dart';
import '../../data/model/task_list_wrapper.dart';
import '../../data/provider/language_provider.dart';
import '../utiles/custom_appbar.dart';
import 'authenication/profile_screen.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({Key? key}) : super(key: key);

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  late bool _getCompletedTaskListInProgress = false;
  late TaskListWrapper _completeTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getAllCompleteTaskList();
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var currentLanguage = languageProvider.currentLanguage;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        callBack: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()));
        },
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 8),
                _buildItemUpdate(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemUpdate() {
    return Visibility(
      visible: _completeTaskListWrapper.taskList?.isNotEmpty ?? false,
      replacement: Center(child: Text('No item')),

      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: _completeTaskListWrapper.taskList?.length ?? 0,
        shrinkWrap: true,
        primary: false,

        itemBuilder: (BuildContext context, index) {
          var languageProvider = Provider.of<LanguageProvider>(context);
          var currentLanguage = languageProvider.currentLanguage;

          return CardItemWidget(
            taskItem: _completeTaskListWrapper.taskList![index],
            refreshData: () {
              _refreshData();
            }, taskStatus: currentLanguage.complete, taskStatusColor: Colors.purple.shade800,
          );
        },
      ),
    );
  }

  Future<void> _refreshData() async {
    await _getAllCompleteTaskList();
  }

  Future<void> _getAllCompleteTaskList() async {
    _getCompletedTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.completedTaskList);

    if (response.isSuccess) {
      _completeTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      _getCompletedTaskListInProgress = false;
      setState(() {});
    } else {
      _getCompletedTaskListInProgress = false;
      setState(() {});
      showSnackBarMessage(
        context,
        response.errorMessage ?? 'Get complete task list has been failed',
      );
    }
    setState(() => _getCompletedTaskListInProgress = false);
  }
}
