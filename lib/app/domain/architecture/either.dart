class Either<L, R> {
  const Either.right(this._right) : _left = null;

  const Either.left(this._left) : _right = null;

  final L? _left;

  final R? _right;

  bool get isLeft => _left != null;

  bool get isRight => _right != null;

  L get left {
    return _left as L;
  }

  R get right {
    return _right as R;
  }
}
