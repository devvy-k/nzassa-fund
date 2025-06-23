abstract class UiState<T> {
  const UiState();
}

class UiStateInitial<T> extends UiState<T> {
  const UiStateInitial();
}

class UiStateLoading<T> extends UiState<T> {
  const UiStateLoading();
}

class UiStateSuccess<T> extends UiState<T> {
  final T data;

  const UiStateSuccess(this.data);
}

class UiStateError<T> extends UiState<T> {
  final String message;

  const UiStateError(this.message);
}