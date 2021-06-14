import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktodo/DB/template_provider.dart';
import 'package:ktodo/Providers/Theme.dart';
import 'package:ktodo/Routes.dart';
import 'package:ktodo/models/template.dart';
import 'package:ktodo/shared/widgets/Drawer.dart';
import 'package:ktodo/widgets/AddTemplate.dart';
import 'package:ktodo/widgets/ConfirmDeleteTemplateDialog.dart';
import 'package:ktodo/widgets/TemplateItem.dart';
import 'package:provider/provider.dart';

class Template extends StatefulWidget {

  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {

  List<TemplateModel> templates = [];
  TemplateProvider provider = new TemplateProvider();

  init() async {
    templates = await provider.getTemplates();
    setState(() { });
  }
  deleteTemplate(index) {
    TemplateModel template;
    setState(() {
      template = templates.removeAt(index);
    });
    provider.delete(template.id);
  }

  @override
  void initState() {
    init();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ThemeModel theme = Provider.of<ThemeModel>(context);
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        title: Text('Template'),
        actions: [
          Row(
            children: [Text('${templates.length}')],
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              TemplateModel template = await showDialog<TemplateModel>(context: context, builder: (context) {
                return AddTemplate();
              });
              if(template == null) {
                return;
              }
              template = await provider.create(template);
              setState(() {
                templates.insert(0, template);
              });
            }
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(15),
        itemBuilder: (BuildContext context, index) {
          TemplateModel template = templates[index];
          return TemplateItem(
            template,
            onDeleteBtnPress: () async {
              if(await showDialog<bool>(context: context, builder: (context) {
                return ConfirmDeleteTemplate(template);
              })) {
                deleteTemplate(index);
              }
            },
          );
        }, itemCount: templates.length,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

