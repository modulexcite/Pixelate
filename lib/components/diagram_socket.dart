import 'package:polymer/polymer.dart';
import 'dart:html';

/**
 * A Polymer click counter element.
 */
@CustomTag('px-diagram-socket')
class DiagramSocket extends PolymerElement {
  /** The image of the socket */
  @published String image = "";
  
  /** The image of the socket when the mouse is hovered over it */
  @published String hoverImage = "";
  
  ImageElement imageElement;
  DiagramSocket.created() : super.created() {}
  
  void ready() {
    super.ready();
    imageElement = this.shadowRoot.querySelector("#socket_image");
    imageElement.onMouseEnter.listen((_) => imageElement.src = hoverImage);
    imageElement.onMouseLeave.listen((_) => imageElement.src = image);
  }
  
  
  
}

