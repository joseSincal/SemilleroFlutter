import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:semiuni_course_app/Place/model/place.dart';
import 'package:semiuni_course_app/Place/ui/widgets/card_image.dart';
import 'package:semiuni_course_app/User/model/user.dart' as us;
import 'package:semiuni_course_app/User/ui/widgets/profile_place.dart';

class CloudFirestoreAPI {
  final String USERS = "users";
  final String PLACES = "places";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateUserData(us.User user) async {
    DocumentReference ref = _db.collection(USERS).doc(user.uid);
    return await ref.set({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavoritePlaces': user.myFavoritePlaces,
      'lastSignIn': DateTime.now()
    }, SetOptions(merge: true));
  }

  Future<void> updatePlaceDate(Place place) async {
    CollectionReference refPlaces = _db.collection(PLACES);
    User? user = _auth.currentUser;

    await refPlaces.add({
      'name': place.name,
      'description': place.description,
      'likes': place.likes,
      'urlImage': place.urlImage,
      'userOwner': _db.doc("$USERS/${user!.uid}"), //reference
      'usersLiked': [] 
    }).then((DocumentReference dr) {
      dr.get().then((DocumentSnapshot snapshot) {
        // ID Place REFERENCIA ARRAY
        DocumentReference refUsers = _db.collection(USERS).doc(user.uid);
        refUsers.update({
          'myPlaces': FieldValue.arrayUnion([_db.doc("$PLACES/${snapshot.id}")])
        });
      });
    });
  }

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) {
    List<ProfilePlace> profilePlaces = List<ProfilePlace>.empty(growable: true);
    for (var p in placesListSnapshot) {
      profilePlaces.add(ProfilePlace(Place(
        name: p['name'],
        description: p['description'],
        urlImage: p['urlImage'],
        likes: p['likes'],
      )));
    }
    return profilePlaces;
  }

  List<Place> buildPlaces(
      List<DocumentSnapshot> placesListSnapshot, us.User user) {
    List<Place> places = List<Place>.empty(growable: true);

    for (var p in placesListSnapshot) {
      Place place = Place(
          id: p.id,
          name: p["name"],
          description: p["description"],
          urlImage: p["urlImage"],
          likes: p["likes"]);

      place.liked = false;
      List usersLikedRefs = p["usersLiked"];

      for (var drUL in usersLikedRefs) {
        if (user.uid == drUL.id) {
          place.liked = true;
        }
      }

      places.add(place);
    }
    return places;
  }

  Future likePlace(Place place, String uid) async {
    await _db
        .collection(PLACES)
        .doc(place.id)
        .get()
        .then((DocumentSnapshot ds) {
      int likes = ds["likes"];
      _db.collection(PLACES).doc(place.id).update({
        'likes': place.liked ? likes + 1 : likes - 1,
        'usersLiked': place.liked
            ? FieldValue.arrayUnion([_db.doc("$USERS/$uid")])
            : FieldValue.arrayRemove([_db.doc("$USERS/$uid")])
      });
    });
  }
}
