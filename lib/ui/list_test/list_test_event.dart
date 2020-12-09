abstract class ListTestEvent{
  const ListTestEvent();
}

class ListTestGetDataOfTest extends ListTestEvent{
  const ListTestGetDataOfTest();
}

class ListTestGetAllTests extends ListTestEvent{
  final String subject;
  final String grade;

  const ListTestGetAllTests(this.subject, this.grade);
}