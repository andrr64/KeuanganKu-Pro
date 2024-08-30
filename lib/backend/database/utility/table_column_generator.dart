Map<String, String> createSql3Column({
  required String name,
  required String dtype,
  String? constraint,
  bool primary = false,
  bool required = false,
  bool unique = false
}){
  if (required){
    constraint = '$constraint NOT NULL';
  }
  if (primary){
    constraint = 'PRIMARY KEY $constraint';
  }
  if (unique){
    constraint = '$constraint UNIQUE';
  }
  return <String, String>{
    'name': name,
    'dtype': dtype,
    'constraint': constraint ?? ''
  };
}