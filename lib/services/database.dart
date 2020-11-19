import './songs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database{
  var _currentUser =  FirebaseAuth.instance.currentUser;
  User getCurrentUser(){
    return _currentUser;
  }
  void addToLikedSongs(Song song){
    Map<String , String> songMap = {
      'artist_img': song.artistImg,
      'artist_name': song.artist,
      'song' : song.songName,
      'url' : song.songUrl,
    };
//    print(FirebaseFirestore.instance.collection('users'));
    FirebaseFirestore.instance.collection('users').doc(_currentUser.uid).collection('liked').doc().set(songMap);
  }
  void fetchSongs(){

  }
}