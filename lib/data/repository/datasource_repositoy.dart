abstract class DataSourceRepositoy {
  Future<void> getRequest({String url});
  Future<void> postRequest({String url, Object object});
  Future<void> putRequest({String url, Object object});
  Future<void> deleteRequest({String url, String id});
}
