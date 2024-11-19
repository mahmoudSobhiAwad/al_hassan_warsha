extension SafeAccess<T> on List<T> {
  T? tryIndex(int index) {
    if (index >= 0 && index <length) {
      return this[index];
    }
    return null; // Return null if out of bounds
  }
}