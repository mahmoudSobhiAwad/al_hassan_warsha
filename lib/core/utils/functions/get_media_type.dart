import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';

MediaType getMediaType (String path){
 
   String fileExtension = path.split('.').last.toLowerCase();  // Gets the file extension in lowercase

    // Check the file type based on the extension
    if (['png', 'jpg', 'jpeg', 'gif'].contains(fileExtension)) {
      return  MediaType.image;
    } else if (['mp4', 'mkv', 'mov'].contains(fileExtension)) {
      return  MediaType.video;
    } else {
      return  MediaType.unknown;
    }
   
}