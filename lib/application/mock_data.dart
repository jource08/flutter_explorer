// Example data (replace with real backend API later)
import 'package:flutter_explorer/domain/entites/file.dart';
import 'package:flutter_explorer/domain/entites/folder.dart';

final Folder mockData = Folder(
  id: '1',
  name: 'Root',
  createdAt: DateTime.now(),
  subFolders: [
    Folder(
      id: '2',
      name: 'Documents',
      createdAt: DateTime.now(),
      icon: 'folder',
      subFolders: [
        Folder(
          id: '3',
          name: 'Projects',
          createdAt: DateTime.now(),
          icon: 'work',
          subFolders: [
            Folder(
              id: '4',
              name: 'Flutter App',
              createdAt: DateTime.now(),
              icon: 'app_registration',
              files: [
                File(
                  id: '101',
                  name: 'main.dart',
                  type: 'dart',
                  size: 1500,
                  folderId: '4',
                  createdAt: DateTime.now(),
                  isHidden: false,
                ),
                File(
                  id: '102',
                  name: 'pubspec.yaml',
                  type: 'yaml',
                  size: 500,
                  folderId: '4',
                  createdAt: DateTime.now(),
                  isHidden: false,
                ),
              ],
              subFolders: [
                Folder(
                  id: '5',
                  name: 'Assets',
                  createdAt: DateTime.now(),
                  files: [
                    File(
                      id: '201',
                      name: 'logo.png',
                      type: 'png',
                      size: 250,
                      folderId: '5',
                      createdAt: DateTime.now(),
                      isHidden: false,
                    ),
                    File(
                      id: '202',
                      name: 'background.jpg',
                      type: 'jpg',
                      size: 1200,
                      folderId: '5',
                      createdAt: DateTime.now(),
                      isHidden: false,
                    ),
                  ],
                ),
              ],
            ),
            Folder(
              id: '6',
              name: 'Web App',
              createdAt: DateTime.now(),
              subFolders: [
                Folder(
                  id: '7',
                  name: 'Assets',
                  createdAt: DateTime.now(),
                  files: [
                    File(
                      id: '301',
                      name: 'index.html',
                      type: 'html',
                      size: 350,
                      folderId: '7',
                      createdAt: DateTime.now(),
                      isHidden: false,
                    ),
                    File(
                      id: '302',
                      name: 'style.css',
                      type: 'css',
                      size: 600,
                      folderId: '7',
                      createdAt: DateTime.now(),
                      isHidden: false,
                    ),
                  ],
                ),
              ],
              files: [
                File(
                  id: '103',
                  name: 'app.js',
                  type: 'js',
                  size: 3200,
                  folderId: '6',
                  createdAt: DateTime.now(),
                  isHidden: false,
                ),
              ],
            ),
          ],
        ),
      ],
      files: [
        File(
          id: '104',
          name: 'Budget.xlsx',
          type: 'xlsx',
          size: 2500,
          folderId: '2',
          createdAt: DateTime.now(),
          isHidden: false,
        ),
      ],
    ),
    Folder(
      id: '8',
      name: 'Pictures',
      createdAt: DateTime.now(),
      subFolders: [
        Folder(
          id: '9',
          name: 'Vacations',
          createdAt: DateTime.now(),
          files: [
            File(
              id: '105',
              name: 'Beach.jpg',
              type: 'jpg',
              size: 3000,
              folderId: '9',
              createdAt: DateTime.now(),
              isHidden: false,
            ),
          ],
          subFolders: [
            Folder(
              id: '10',
              name: 'Summer 2024',
              createdAt: DateTime.now(),
              files: [
                File(
                  id: '106',
                  name: 'Sunset.png',
                  type: 'png',
                  size: 1200,
                  folderId: '10',
                  createdAt: DateTime.now(),
                  isHidden: false,
                ),
              ],
            ),
          ],
        ),
        Folder(
          id: '11',
          name: 'Family',
          createdAt: DateTime.now(),
          files: [
            File(
              id: '107',
              name: 'Christmas.jpg',
              type: 'jpg',
              size: 2000,
              folderId: '11',
              createdAt: DateTime.now(),
              isHidden: false,
            ),
          ],
        ),
      ],
    ),
    Folder(
      id: '12',
      name: 'Videos',
      createdAt: DateTime.now(),
      files: [
        File(
          id: '108',
          name: 'Family Reunion.mp4',
          type: 'mp4',
          size: 150000,
          folderId: '12',
          createdAt: DateTime.now(),
          isHidden: false,
        ),
      ],
      subFolders: [
        Folder(
          id: '13',
          name: 'Travel',
          createdAt: DateTime.now(),
          files: [
            File(
              id: '109',
              name: 'Vacation Vlog.mp4',
              type: 'mp4',
              size: 100000,
              folderId: '13',
              createdAt: DateTime.now(),
              isHidden: false,
            ),
          ],
          subFolders: [
            Folder(
              id: '14',
              name: '2023',
              createdAt: DateTime.now(),
              files: [
                File(
                  id: '110',
                  name: 'Trip to Paris.mp4',
                  type: 'mp4',
                  size: 120000,
                  folderId: '14',
                  createdAt: DateTime.now(),
                  isHidden: false,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
