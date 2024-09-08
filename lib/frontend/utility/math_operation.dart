double getPercentage(double x, double y){
  if (x == 0){
    return 0;
  }
  if (x >= y){
    return 1;
  }
  return x/y;
}