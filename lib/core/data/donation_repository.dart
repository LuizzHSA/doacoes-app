import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../shared/models/campaign.dart';
import '../../shared/models/donation_item.dart';

class DonationRepository {
  DonationRepository({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const _configuredBaseUrl = String.fromEnvironment('API_BASE_URL');

  String get _baseUrl {
    if (_configuredBaseUrl.isNotEmpty) return _configuredBaseUrl;
    return defaultTargetPlatform == TargetPlatform.android
        ? 'http://10.0.2.2:8000'
        : 'http://localhost:8000';
  }

  Future<List<Campaign>> fetchCampaigns() async {
    final data = await _getList('/api/campaigns');
    return data.map(Campaign.fromJson).toList();
  }

  Future<List<DonationItem>> fetchDonations() async {
    final data = await _getList('/api/donations');
    return data.map(DonationItem.fromJson).toList();
  }

  Future<List<Map<String, dynamic>>> _getList(String path) async {
    final response = await _client
        .get(Uri.parse('$_baseUrl$path'))
        .timeout(const Duration(seconds: 15));
    if (response.statusCode != 200) {
      throw Exception('A API respondeu com status ${response.statusCode}.');
    }
    final decoded = jsonDecode(response.body);
    if (decoded is! List) {
      throw const FormatException('Resposta inesperada da API.');
    }
    return decoded.cast<Map<String, dynamic>>();
  }
}