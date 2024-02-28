import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavItem {
  final int id;
  final IconData icon;
  final String label;

  NavItem({required this.label, required this.id, required this.icon});
}

List<NavItem> navItems = [
  NavItem(label: "홈", id: 0, icon: Icons.home),
  NavItem(label: "공개 예정", id: 1, icon: FontAwesomeIcons.film),
  NavItem(
      label: "저장한 콘텐츠 목록", id: 2, icon: FontAwesomeIcons.arrowAltCircleDown),
];
