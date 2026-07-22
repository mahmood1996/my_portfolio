import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/experience_model.dart';
import '../models/project_model.dart';
import '../models/reading_model.dart';
import '../models/skill_model.dart';

abstract class PortfolioLocalDataSource {
  Future<List<ExperienceModel>> getExperiences();
  Future<List<ProjectModel>> getProjects();
  Future<List<SkillModel>> getSkills();
  Future<List<ReadingModel>> getReadings();
}

class PortfolioLocalDataSourceImpl implements PortfolioLocalDataSource {
  final AssetBundle _assetBundle;
  final String _jsonPath;

  Map<String, dynamic>? _cachedData;

  PortfolioLocalDataSourceImpl({
    AssetBundle? assetBundle,
    this._jsonPath = 'assets/data/portfolio_data_v2.json',
  }) : _assetBundle = assetBundle ?? rootBundle;

  Future<Map<String, dynamic>> _loadJsonData() async {
    if (_cachedData != null) {
      return _cachedData!;
    }
    final jsonString = await _assetBundle.loadString(_jsonPath);
    _cachedData = json.decode(jsonString) as Map<String, dynamic>;
    return _cachedData!;
  }

  @override
  Future<List<ExperienceModel>> getExperiences() async {
    final data = await _loadJsonData();
    final list = data['experiences'] as List<dynamic>? ?? [];
    return list
        .map((item) => ExperienceModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ProjectModel>> getProjects() async {
    final data = await _loadJsonData();
    final list = data['projects'] as List<dynamic>? ?? [];
    return list
        .map((item) => ProjectModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<SkillModel>> getSkills() async {
    final data = await _loadJsonData();
    final list = data['skills'] as List<dynamic>? ?? [];
    return list
        .map((item) => SkillModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ReadingModel>> getReadings() async {
    final data = await _loadJsonData();
    final list = data['readings'] as List<dynamic>? ?? [];
    return list
        .map((item) => ReadingModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
