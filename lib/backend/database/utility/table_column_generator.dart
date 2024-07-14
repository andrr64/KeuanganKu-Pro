Map<String, String> createSql3Column({
  required String name,
  required String dtype,
  String? constraint,
  bool? primary,
  bool? required
}){
  if (required == true){
    constraint = '$constraint NOT NULL';
  }
  if (primary == true){
    constraint = 'PRIMARY KEY $constraint';
  }
  return <String, String>{
    'name': name,
    'dtype': dtype,
    'constraint': constraint ?? ''
  };
}