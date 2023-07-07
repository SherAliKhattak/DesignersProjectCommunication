import 'package:elabd_project/components/custom_text_field.dart';
import 'package:elabd_project/data/services/firebase_db.dart';
import 'package:elabd_project/models/designers_model.dart';
import 'package:elabd_project/models/project_model.dart';
import 'package:elabd_project/screens/dashboard/users_list_view.dart';
import 'package:elabd_project/screens/designer_details/designer_details.dart';
import 'package:elabd_project/screens/new_project_screen.dart/new_project.dart';
import 'package:elabd_project/screens/project_details/project_details.dart';
import 'package:elabd_project/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/chat_contact.dart';

class ChatsTab extends StatelessWidget {
  const ChatsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(paddingLarge(context)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<List<ChatContact>>(
                  stream: FirebaseDB().getAllChats(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final chat = snapshot.data![index];
                            return UsersListview(
                              chat: chat,
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectsTab extends StatefulWidget {
  const ProjectsTab({
    super.key,
  });

  @override
  State<ProjectsTab> createState() => _ProjectsTabState();
}

class _ProjectsTabState extends State<ProjectsTab> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        centerTitle: true,
        actions: [
          TextButton.icon(
              onPressed: () {
                Get.to(() => const NewProject());
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: const Text(
                'Add project',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(paddingExtraLarge(context)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                controller: search,
                onChanged: (value) {
                  setState(() {});
                },
                borderRadius: 10,
                hintText: 'Search',
                suffixIconData: const Icon(Icons.search),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              StreamBuilder<List<ProjectModel>>(
                  stream: FirebaseDB().displayProjects(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ProjectModel> filter = snapshot.data!;
                      if (search.text != '') {
                        filter = filter.where((element) {
                          if (element.title
                              .toString()
                              .toLowerCase()
                              .contains(search.text.toLowerCase())) {
                            return true;
                          } else {
                            return false;
                          }
                        }).toList();
                      }
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filter.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final project = filter[index];
                            return InkWell(
                              onTap: () {
                                Get.to(() => ProjectDetails(
                                      pj: project,
                                    ));
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${project.title}',
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        )
                                      ],
                                    ),
                                    subtitle: Text(
                                      '${project.description}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    trailing: Text(
                                      '${project.status}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color:
                                              projectStatus(project.status!)),
                                    ),
                                  )),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

Color projectStatus(String status) {
  if (status == 'Pending') {
    return Colors.yellow;
  }
  if (status == 'Confirmed') {
    return Colors.green;
  }
  if (status == 'Pending') {
    return Colors.lightBlueAccent;
  } else {
    return Colors.red;
  }
}

class DesignersTab extends StatefulWidget {
  const DesignersTab({
    super.key,
  });

  @override
  State<DesignersTab> createState() => _DesignersTabState();
}

class _DesignersTabState extends State<DesignersTab> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Designers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                controller: search,
                onChanged: (value) {
                  setState(() {});
                },
                borderRadius: 10,
                hintText: 'Search for designers',
                suffixIconData: const Icon(Icons.search),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              StreamBuilder<List<DesignersModel>>(
                  stream: FirebaseDB().getDesigners(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<DesignersModel> filter = snapshot.data!;
                      if (search.text != '') {
                        filter = filter.where((element) {
                          if (element.name
                              .toString()
                              .toLowerCase()
                              .contains(search.text.toLowerCase())) {
                            return true;
                          } else {
                            return false;
                          }
                        }).toList();
                      }
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filter.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final designer = filter[index];
                            return Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                onTap: () {
                                  Get.to(()=>DesignerDetails(designer: designer));
                                },
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      NetworkImage(designer.image!),
                                ),
                                title: Text(designer.name!),
                                subtitle: Text(designer.bio!),
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> paymentMethodTabs = [
  Row(
    mainAxisSize: MainAxisSize.min,
    children: const [
      Center(
        child: Text(
          'Projects',
          style: TextStyle(color: Colors.black),
        ),
      )
    ],
  ),
  const Center(
    child: Text(
      'Designers',
      style: TextStyle(color: Colors.black),
    ),
  ),
  const Center(
    child: Text(
      'Chats',
      style: TextStyle(color: Colors.black),
    ),
  ),
  const Center(
    child: Text(
      'Profile',
      style: TextStyle(color: Colors.black),
    ),
  )
];
