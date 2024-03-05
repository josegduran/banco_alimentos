import 'package:banco_alimentos/models/usuariosModel.dart';
import 'package:gsheets/gsheets.dart';

class usuariosController {
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "bamx-414404",
  "private_key_id": "01b951dc2b7b0f7a40b3cdbab0e58d3cf41c6892",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDMi+Drfic1VJoX\nqZ9vciV3RpvZG5OmY/eEumuY8phuS+io1UKtJhB7imx5U/VHehUoR3X2lQNC+WiR\n4+zIiIUzz67WTx7HmOvpFEdlZyMZbuXOm1XtXB6aIV3bzUK108omBfBq1WQOYmsA\nZLCr3HrKpGvhVx311sj8cksKe7u3UfiKr17iprE7ZDqycZkRFYwmSWc/lqk5gxJe\nSMPcG5AuoxV7+wRIMXZUhDAQ5hKcKP5MCANnwsu+CM4bK0vgSh4Or1Fk7OePCfHN\nHJG8Rd3nnfmeOLYTj4eefJX/9EP5eFGzHmPQe1A8Ins3cErv9sbqw+IwCURA8Xfu\nBDb6/M2fAgMBAAECggEAGwG4/77XVG5ILimiOGe81KPI/gBrHUQDsU2f2UDmqWFy\nZaBKvmvRL06Whep07ywKURgmVhlUpeoiSWjroYqM88tPDVLDAJ2LQGoCBzx34OrI\ngt/1l3JbRAR1zQir7y/4d86+8IweOtv5vsKMpRRmTg0phUYoWYYzYUmB6O9vWIPI\niP7PRB4aQ5U/NeswDv7uPzB9EjsoXuYSCmICtwBfY7q9VzzJxi3GhMI8f3I11Go2\nMXX/2hV2lMq36CQgQWOcI1kKYOxu07HUzhxnK5tV0C1Ac+YgLQTEZAe/gKwV2tQg\nPCErmfL2A9vbL4s6SxeB/sGcOFjF61X4C1gvUT07eQKBgQD4VNmkdG3WYyOpexax\ncRxRDZeYZjyL+wi5jI31d2JLMa3DGnNMDNn9shn3O2/eCg/pkuL4txJlwsJYZEKC\n+L83sSWolVtlE3Y6TDfrEFZXwxixiE+Y+zzUq+zNGBEF3zASIoZfY7skq0lPrbw8\nMAvbAVQTSJwr2i1zPqZKr+LHiwKBgQDS3OROVCWN2A9BRbi/22kOLsXb54Q5wy8G\naUrxJ9W/lff7fXv5WYCS63fDr6kc+Q2N6d2dMXa3oQCPIdvJAe+9a7u5vAw8c3OD\nb3Yc3SZ7EAu6MOAHYBGR7785OmIWhTQRwm7ImaTsYJlLY6UIf22RG3oTMA7MuC/u\n/WfYEv30vQKBgCMXcm3v2fmaptZzQ2CtuC+n+Q0bHWE2hyQZPZI7XZN8oK5aVYKg\nqklUWqD6MDOzPk5maFZ3IE1q+SWefVuepP7MtKKfAHxHBMT2MkywUVMziZDEz2Kx\n1gXDicHtrbIjuNpHMK/YGwDyh3iP93KV44b+KBBViWQU/6kyaDNTqXtDAoGBAL11\nAxzttiBQNMSs5GZduXKoy9XdmoxbtvDHwjITXJYbJQitoqpTpJZdQupr9kK181vC\n+P+35bbvzhTMkzFzr/g9yBoFv+jAwtUhXLpqaZzAugi8yU1XH/JDu0isEF2zqSkb\nzXYntms8EAAQs8OC2us6COEcmO+PvmG5BYi657rxAoGBAO+2HDsCBaGgrMTirpLD\nnHFAyOOkxrZZH9moFf9APpeZZEAiky32IHWA5c3v+FBXSaEzd+XfHa1RLVcXjyR1\n2nTYSNhqemgFEw6mGCIJRNFR+x59sdPQ4XOtrjrLGGOEcSzOlS7GDCwFnUbzxwVI\nlAGlD1j2jiKonxRGLe8ZioxC\n-----END PRIVATE KEY-----\n",
  "client_email": "bamx-806@bamx-414404.iam.gserviceaccount.com",
  "client_id": "112746226617649655922",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/bamx-806%40bamx-414404.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
  }
  ''';

  static final _spreadsheetId = '1SuxsEvDehT-BVc3t_j9iKvmbPgnkoulf8fcqtFqmQLo';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'usuarios');

      final firstRow = Usuarios.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCount() async {
    if (_userSheet == null) return 0;

    final lastRow = await _userSheet!.values.lastRow();
    final firstCellValue = lastRow?.first;
    return int.tryParse(firstCellValue ?? '0') ?? 0;
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }

  static Future<List<Map<String, dynamic>>> readAllRows() async {
    if (_userSheet == null) return [];

    final values = await _userSheet!.values.allRows();
    final headers = Usuarios.getFields();

    // Filtrar las filas que tienen 'pendiente' en la columna 'estado'
    final filteredRows = values.where((row) {
      final rowData = Map<String, dynamic>.fromIterables(headers, row);
      return rowData['estado'] == 'Activo';
    }).toList();

    // Convertir las filas de valores filtradas en una lista de mapas
    final rows = filteredRows.map((row) {
      Map<String, dynamic> rowData = {};
      for (int i = 0; i < headers.length; i++) {
        rowData[headers[i]] = row[i];
      }
      return rowData;
    }).toList();

    return rows;
  }
}
