// Copyright (c) 2013-2014, the Pixelate Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [Accordion] class.
library pixelate_accordion;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as Html;

//---------------------------------------------------------------------
// Package libraries
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';
import 'package:pixelate/components/expander/expander.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'px-accordion';

/// Displays a list of [Expander] items, and controls their display.
///
/// By default the [Accordion] allows only a single [Expander] to be open at
/// a time. When a different [Expander] is selected the previously active
/// instance will be collapsed. This can be modified by specifying the
/// [multiple] attribute.
///
///     <!-- Select single element; the default -->
///     <px-accordion>
///       <px-expander></px-expander>
///       <px-expander></px-expander>
///       <px-expander></px-expander>
///     </px-accordion>
///     <!-- Select multiple elements -->
///     <px-accordion multiple>
///       <px-expander></px-expander>
///       <px-expander></px-expander>
///       <px-expander></px-expander>
///     </px-accordion>
@CustomTag(_tagName)
class Accordion extends PolymerElement {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static String get customTagName => _tagName;

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// Whether multiple [Expander]s can be opened at the same time.
  @published bool multiple = false;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Create an instance of the [Accordion] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// [Element.tag] constructor as follows.
  ///
  ///     var instance = new Element.tag(Accordion.customTagName);
  Accordion.created()
      : super.created();

  //---------------------------------------------------------------------
  // Events
  //---------------------------------------------------------------------

  /// Callback for when value of [multiple] changes.
  void multipleChanged(bool oldValue) {
    if (!multiple) {
      // Find the first element that is expanded
      var elements = querySelectorAll(Expander.customTagName);

      for (var element in elements) {
        var expander = element as Expander;

        if (expander.expanded) {
          _collapseOthers(expander);

          return;
        }
      }
    }
  }

  /// Callback for when an element is expanded.
  void onExpanded(Html.Event e, var details, Html.Node target) {
    if (!multiple) {
      _collapseOthers(details as Expander);
    }
  }

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Collapses any elements that aren't [expanded].
  void _collapseOthers(Expander expanded) {
    var elements = querySelectorAll(Expander.customTagName);

    for (var element in elements) {
      var expander = element as Expander;

      if (expander != expanded) {
        expander.expanded = false;
      }
    }
  }
}
