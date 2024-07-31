mixin Interpolatable<T> {
  T lerp(T? other, double t);
}

mixin Copyable<T> {
  T copyWith();
}

mixin ThemeComponent<T> implements Interpolatable<T>, Copyable<T> {}
