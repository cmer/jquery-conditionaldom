###
ConditionalDom is a jQuery plugin that makes it easy to conditionally
execute simple actions on DOM elements.

For example, if the current user is an administrator, you might want to
show a certain DIV, but hide it when the user is not an administrator.

@name conditionaldom
@version 0.3.1
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
    options['true_action'] ||= ($e) ->
      # This is faster than .replaceWith()
      $e.children().insertAfter($e);
      $e.remove()
    options['false_action'] ||= ($e) ->
      $e.remove()

    this.find("#{options['selector']}:not(.executed), #{options['selector']}.multi").each (index, e) =>
      $e = $(e)
      if e.getAttribute("data-if") || e.getAttribute("data-unless")
        code        = "(#{e.getAttribute("data-if") || e.getAttribute("data-unless")})"
        trueAction  = e.getAttribute("data-true-action")  || options["true_action"]
        falseAction = e.getAttribute("data-false-action") || options["false_action"]

        if e.getAttribute("data-if")
          code = "if " + code
        else if $e.getAttribute("data-unless")
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