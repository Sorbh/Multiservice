import 'dart:async';

import 'package:multiservice/data/local/DbHelper.dart';
import 'package:multiservice/data/wrapper/order.dart';
import 'package:sqflite/sqflite.dart';

class NotificationMessageProvider {
  static Future<int> insert(
      Order Order) async {
    Database db = await DbHelper.getDb();
    return db.insert(
        DbHelper.ORDER_TBL, Order.toJson());
  }

  static Future<List<Order>> getAllNotification() async {
    Database db = await DbHelper.getDb();
    List<Map> maps = await db.query(DbHelper.ORDER_TBL);
    if (maps.length > 0) {
      List<Order> analysisList = List();
      for (int i = 0; i < maps.length; i++) {
        analysisList.add(Order.fromJson(maps[i]));
      }
      return Future.value(analysisList);
    }
    return null;
  }

  static Future<List<Order>> getOpenNotificationByType(
      String type, String isOpen) async {
    Database db = await DbHelper.getDb();
    List<Map> maps = await db.query(DbHelper.ORDER_TBL,
        where: 'type = ? AND isOpen = ?', whereArgs: [type, isOpen]);
    if (maps.length > 0) {
      List<Order> analysisList = List();
      for (int i = 0; i < maps.length; i++) {
        analysisList.add(Order.fromJson(maps[i]));
      }
      return Future.value(analysisList);
    }
    return null;
  }

  //we need this method becuase, feed have NEW_POST and NEW_COMMENT both type
  static Future<List<Order>> getOpenFeedNotification(
      String isOpen) async {
    Database db = await DbHelper.getDb();
    List<Map> maps = await db.query(DbHelper.ORDER_TBL,
        where: 'isOpen = ? AND (type = ? OR type = ?)',
        whereArgs: [isOpen, 'NEW_POST', 'NEW_COMMENT']);
    if (maps.length > 0) {
      List<Order> analysisList = List();
      for (int i = 0; i < maps.length; i++) {
        analysisList.add(Order.fromJson(maps[i]));
      }
      return Future.value(analysisList);
    }
    return null;
  }

  static Future<List<Order>> getUnreadNotification() async {
    Database db = await DbHelper.getDb();
    List<Map> maps = await db.query(DbHelper.ORDER_TBL,
        where: 'isCheck = ? AND NOT type = ?', whereArgs: [0, 'NEW_NETWORK']);
    if (maps.length > 0) {
      List<Order> analysisList = List();
      for (int i = 0; i < maps.length; i++) {
        analysisList.add(Order.fromJson(maps[i]));
      }
      return Future.value(analysisList);
    }
    return null;
  }

  static Future<List<Order>>
      getUnreadReferNotification() async {
    Database db = await DbHelper.getDb();
    List<Map> maps = await db.query(DbHelper.ORDER_TBL,
        where: 'isCheck = ? AND (type = ? OR type = ?)',
        whereArgs: [0, 'NEW_NETWORK', 'NEW_MESSAGE']);
    if (maps.length > 0) {
      List<Order> analysisList = List();
      for (int i = 0; i < maps.length; i++) {
        analysisList.add(Order.fromJson(maps[i]));
      }
      return Future.value(analysisList);
    }
    return null;
  }

  //Method the get Unread message count for Network
  static Future<List<Order>>
      getUnreadMessageNotificationForNetwork(String networkId) async {
    Database db = await DbHelper.getDb();
    List<Map> maps = await db.query(DbHelper.ORDER_TBL,
        where: 'isOpen = ? AND type = ? AND n_id = ?',
        whereArgs: [0, 'NEW_MESSAGE', networkId]);
    if (maps.length > 0) {
      List<Order> analysisList = List();
      for (int i = 0; i < maps.length; i++) {
        analysisList.add(Order.fromJson(maps[i]));
      }
      return Future.value(analysisList);
    }
    return null;
  }

  static markNotificationCheck() async {
    Database db = await DbHelper.getDb();
    await db.execute(
        'UPDATE ${DbHelper.ORDER_TBL} SET isCheck = ? WHERE NOT type = ?',
        [1, 'NEW_NETWORK']);
  }

  static markReferCheck() async {
    Database db = await DbHelper.getDb();
    await db.execute(
        'UPDATE ${DbHelper.ORDER_TBL} SET isCheck = ? WHERE (type = ? OR type = ?)',
        [1, 'NEW_NETWORK', 'NEW_MESSAGE']);
  }

  static markAllMessageOpenForNetwork(String networkId) async {
    Database db = await DbHelper.getDb();
    await db.execute(
        'UPDATE ${DbHelper.ORDER_TBL} SET isOpen = ? WHERE (type = ? AND n_id = ?)',
        [1, 'NEW_MESSAGE', networkId]);
  }

  // static Future<List<Order>>
  //     getOrderByType(int type) async {
  //   Database db = await DbHelper.getDb();
  //   List<Map> maps = await db.query(DbHelper.ORDER_TBL,
  //       where: "analysis_type= ?", whereArgs: [type], orderBy: 'id desc');
  //   if (maps.length > 0) {
  //     List<Order> analysisList = List();
  //     for (int i = 0; i < maps.length; i++) {
  //       analysisList.add(Order.fromJsonWithRead(maps[i]));
  //     }
  //     return Future.value(analysisList);
  //   }
  //   return null;
  // }
}
