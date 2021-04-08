class Student {
  String _name = "";
  int _rollno = 0;
  String _dept = "";

  void set name(String val) {
    _name = val;
  }

  //void setName(String val) {
  //  _name = val;
  //}

  String get name => _name;

  void set rollno(int val) {
    _rollno = val;
  }

  int get rollno => _rollno;

  void set dept(String val) {
    _dept = val;
  }

  String get dept => _dept;
}

class Student2 {
  String _name = "";
  int _rollno = 0;
  String _dept = "";

  //Student2(this._name, this._rollno, this._dept) {}
  Student2(String n, int r, String d)
      : this._name = n,
        this._rollno = r,
        this._dept = d {}

  String get name => _name;
  int get rollno => _rollno;
  String get dept => _dept;
}

class Student3 {
  String _name = "";
  int _rollno = 0;
  String _dept = "";

  Student3.AllInfo(this._name, this._rollno, this._dept) {}
  Student3.NameRollno(this._name, this._rollno) {}

  void set dept(String val) {
    _dept = val;
  }

  String get name => _name;
  int get rollno => _rollno;
  String get dept => _dept;
}

main() {
  var s = new Student();
  s.name = "Ashish"; // setter methods
  s.rollno = 1424;
  s.dept = "ECE";

  //print('Student record: ${s.name} : ${s.rollno} : ${s.dept}');

  //return;

  //var s2 = new Student2("Vikram", 312, "CSE");

  //print('Student2 record: ${s2.name} : ${s2.rollno} : ${s2.dept}');

  //return;

  var s3a = new Student3.AllInfo("Subhash", 1413, "CSE");

  print('Student3 record: ${s3a.name} : ${s3a.rollno} : ${s3a.dept}');

  var s3b = new Student3.NameRollno("Srushti", 235);
  s3b.dept = "ECE";

  print('Student3 record: ${s3b.name} : ${s3b.rollno} : ${s3b.dept}');
}
