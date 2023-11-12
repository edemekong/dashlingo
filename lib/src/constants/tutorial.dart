import 'package:dashlingo/src/features/learn/data/models/learn/paragraph.dart';
import '../features/learn/data/models/learn/tutorial.dart';

Tutorial tutorial = Tutorial(
  id: '-123-',
  title: 'Theming Your Flutter App',
  description: 'With great theming comes great app!',
  paragraphs: [
    const Paragraph(
      id: '-456-',
      title: 'Overview',
      index: 0,
      type: 'text',
      content:
          "In the Boxtout planning series, we created a task to show the user a custom dialog if the region doesn't exist in the region's collection. This tutorial will go over a step-by-step guide of creating the custom dialog using the DialogService that we're use to using in the Stacked architecture.",
    ),
    const Paragraph(
      id: '-456-',
      index: 1,
      type: 'seperator',
      content: "/space",
    ),
    const Paragraph(
      id: '-789-',
      index: 2,
      type: 'image',
      content: "https://miro.medium.com/max/1200/1*HEoLBLidT2u4mhJ0oiDgig.png",
    ),
    const Paragraph(
      id: '-456-',
      index: 3,
      type: 'seperator',
      content: "/space",
    ),
    const Paragraph(
      id: '-101112-',
      index: 4,
      type: 'text',
      title: 'Building the Custom Dialog',
      content:
          "https://flutter.dev To setup a custom dialog with the DialogService you need to register builders. Each builder is mapped to a different value, we'll use enums. Create a new folder named enums in the lib folder inside it create a file called dialog_type.dart . This enum will have a value for each custom dialog we will build, we will use this enum to decide which custom dialog should to show, for now we just need one :",
    ),
    const Paragraph(
      id: '-101112-',
      index: 5,
      type: 'code',
      content: """/// The type of dialog to show
enum DialogType { basic }""",
    ),
    const Paragraph(
      id: '-101112-',
      index: 6,
      type: 'code',
      content: """class User{
  final String name;
  final String email;

  const User(this.name,this.email);
}
""",
    ),
  ],
  author: {},
  createdAt: 123,
  updatedAt: 123,
);
