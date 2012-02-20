
  /*
  ConditionalDom is a jQuery plugin that makes it easy to conditionally
  execute simple actions on DOM elements.
  
  For example, if the current user is an administrator, you might want to
  show a certain DIV, but hide it when the user is not an administrator.
  
  @name conditionaldom
  @version 0.1.0
  @date 02-20-2012
  @requires jQuery v1.2.3+
  @author Carl Mercier
  @license MIT License - http://www.opensource.org/licenses/mit-license.php
  
  For usage and examples, visit:
  http://github.com/cmer/jquery-conditionaldom/
  
  Copyright (c) 2012, Carl Mercier (c -[at]- cmer [*dot*] me)
  */

  (function($) {
    return $.fn.conditionalDom = function() {
      var _this = this;
      return this.find(".conditionalDom:not(.executed), .conditionalDom.multi").each(function(index, e) {
        var $e, code, falseAction, trueAction;
        $e = $(e);
        if ($e.data("if") || $e.data("unless")) {
          code = "(" + ($e.data("if") || $e.data("unless")) + ")";
          trueAction = $e.data("true-action") || "$e.show();";
          falseAction = $e.data("false-action") || "$e.hide();";
          if ($e.data("if")) {
            code = "if " + code;
          } else if ($e.data("unless")) {
            code = "if (!" + code + ")";
          }
          code += " { " + trueAction + " } else { " + falseAction + " }";
          eval(code);
          $e.addClass('executed');
          return true;
        }
      });
    };
  })(jQuery);
