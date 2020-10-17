import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:messio/models/Message.dart';
import 'package:messio/models/VideoWrapper.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AttachmentsState extends Equatable {
  AttachmentsState([List props = const <dynamic>[]]);
}

class InitialAttachmentsState extends AttachmentsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchedAttachmentsState extends AttachmentsState {
  final List<Message> attachments;
  final FileType fileType;

  FetchedAttachmentsState(this.fileType, this.attachments)
      : super([attachments, fileType]);

  @override
  String toString() =>
      'FetchedAttachmentsState { attachments : $attachments , fileType : $fileType}';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchedVideosState extends AttachmentsState {
  final List<VideoWrapper> videos;

  FetchedVideosState(this.videos) : super([videos]);

  @override
  String toString() => 'FetchedVideosState { videos : $videos }';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
