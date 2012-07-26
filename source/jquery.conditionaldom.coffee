###
ConditionalDom is a jQuery plugin that makes it easy to conditionally
execute simple actions on DOM elements.

For example, if the current user is an administrator, you might want to
show a certain DIV, but hide it when the user is not an administrator.

@name conditionaldom
@version 0.3.0
@date 7/25/2012
@requires jQuery v1.2.3+
@author Carl Mercier
@license MIT License - http://www.opensource.org/licenses/mit-license.php

For usage and examples, visit:
http://github.com/cmer/jquery-conditionaldom/

Copyright (c) 2012, Carl Mercier (c -[at]- cmer [*dot*] me)
###

(($) ->
  $.fn.conditionalDom = (options = {}) ->
    options['selector'] ||= '.conditionalDom'
    this.find("#{options['selector']}:not(.executed), #{options['selector']}.multi").each (index, e) =>
      $e = $(e)
      if $e.data("if") || $e.data("unless")
        code        = "(#{$e.data("if") || $e.data("unless")})"
        trueAction  = $e.data("true-action")  || options["true_action"] || "$e.replaceWith($e.html());"
        falseAction = $e.data("false-action") || options["false_action"] || "$e.remove();"

        if $e.data("if")
          code = "if " + code
        else if $e.data("unless")
          code = "if (!" + code + ")"

        code +=  "{ true } else { false }"
        result = eval(code)
        action = if result is true then trueAction else falseAction
        if $.isFunction(action)
          action($e)
        else
          eval action

        $e.addClass('executed')
        true
) jQuery