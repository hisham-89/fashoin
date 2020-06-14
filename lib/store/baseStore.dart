
class BaseStore {
  dynamic store;
  BaseStore(this.store);
  delete(id){
    store.delete(id);

  }
}