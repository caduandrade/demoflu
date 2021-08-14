abstract class ExampleMenuWidget {
  ExampleMenuWidget({required this.id});

  final int id;
}

class MenuButton extends ExampleMenuWidget {
  MenuButton({required int id, required this.name}) : super(id: id);

  final String name;
}
