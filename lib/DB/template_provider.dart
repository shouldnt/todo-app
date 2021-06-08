import 'package:ktodo/models/template.dart';

import '../constants.dart';
import 'base_provider.dart';

class TemplateProvider extends BaseProvider {
  Future<TemplateModel> create(TemplateModel template) async {
    template.id = await this.db.insert(tableTemplate, template.toMap());
    return template;
  }
  Future<List<TemplateModel>> getTemplates() async {
    try {
      List<Map> maps = await db.query( tableTemplate, orderBy: "datetime(created_at) desc",);
      List<TemplateModel> templates = maps.map<TemplateModel>((templateMap) {
        return TemplateModel.fromMap(templateMap);
      }).toList();
      return templates;
    } catch(error) {
      return [];
    }
  }

  Future<int> update(TemplateModel template) async {
    return await db.update(tableTemplate, template.toMap(),
      where: 'id = ?', whereArgs: [template.id]);
  }
  Future<int> delete(int id) async {
    return await db.delete(tableTemplate, where: 'id = ?', whereArgs: [id]);
  }
}