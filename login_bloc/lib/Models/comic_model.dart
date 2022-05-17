class Comic {
  late String name;

  Comic.fromService(Map<String, dynamic> data) {
    name = data['etag'];
    //this.name = data['data']['results']['name'];
  }
}
