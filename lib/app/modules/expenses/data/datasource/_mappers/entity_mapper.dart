mixin EntityMapper<I, O> {
  O toEntity();
  I fromEntity(O entity);
}