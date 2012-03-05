# jquery.conditionaldom.js

ConditionalDom is a jQuery plugin that makes it easy to conditionally execute simple actions on DOM elements based on Javascript conditions.

## Behavior

When the ConditionalDom if statement evaluates to `true`, the ConditionalDom element (i.e. the one with the .conditionalDom class) will be replaced by its innerHTML.

When the statement evaluates to `false`, the ConditionalDom element is completely removed from the DOM.

This behavior can be changed. See the intermediate examples for details.

ConditionalDom will also only evaluate the conditional statement only once per DOM element, unless the `multi` class is specified. See examples for details.

## Examples

### n00b

Show a DIV based on the user id.

    <script>
      window.Application = {}
      Application.meta = {userId: 1, isAdmin: true};
      $(document).ready(function() { $(document).conditionalDom(); });
    </script>

    <div class="conditionalDom" data-if="Application.meta.userId == 1">
      This is displayed because userId is 1.
    </div>


Show a DIV if the user is an admin, and show another if if the user is not.

    <script>
      window.Application = {}
      Application.meta = {userId: 1, isAdmin: true};
      $(document).ready(function() { $(document).conditionalDom(); });
    </script>

    <div class="conditionalDom" data-if="Application.meta.isAdmin">
      Welcome, admin!
    </div>

    <div class="conditionalDom" data-unless="Application.meta.isAdmin">
      Welcome, mere mortal!
    </div>

### Intermediate

You can also have more complex if/unless statements

    <script>
      window.Application = {}
      Application.meta = {isMale: true, isAdmin: true};
      $(document).ready(function() { $(document).conditionalDom(); });
    </script>

    <div class="conditionalDom" data-if="Application.meta.isMale && Application.meta.isAdmin">
      Welcome, Mr. Admin!
    </div>

    <div class="conditionalDom" data-if="!Application.meta.isMale && Application.meta.isAdmin">
      Welcome, Mrs. Admin!
    </div>

By default, ConditionalDom will only run the if/unless statements once, regardless of how many times the `conditionalDom()` function is called. However, if you want to execute the conditional statement to be executed multiple times, add the *multi* class to the DOM element.

For `multi` to work as expected, it is important to make sure that the ConditionalDom element is *NOT* removed from the DOM after it is evaluated, which is the default behavior. You should override the `data-true-action` and `data-false-action` attributes to something like `$e.show();` and `$e.hide();`.

For example:

    <div class="conditionalDom multi" data-if="true" data-true-action="$e.show();" data-false-action="$e.hide();">
    </div>

### Advanced

ConditionalDom also lets you specify what to do after evaluating the conditional statement of the DOM element.

To do so, add some JavaScript code to the `data-true-action` or `data-false-action` attributes. The `e` and `$e` variables are available to you. `e` is the element itself, and `$e` is a shortcut to `$(e)`.

    <script>
      window.Application = {}
      Application.meta = {userId: 1, isAdmin: true};
      $(document).ready(function() { $(document).conditionalDom(); });
    </script>

    <div class="conditionalDom" data-if="Application.meta.isAdmin"
                                data-true-action="$e.innerHTML('Welcome Admin! Your user id is ' + Application.meta.userId);$e.show();"
                                data-false-action="alert('Access Denied!');$e.hide();">
    </div>

To hide an element from the DOM when the condition evaluates to `false`, just set `data-false-action` as follow:

    <div class="conditionalDom" data-if="true == false"
                                data-false-action="$e.hide();">
      This will be hidden from the DOM instead of removed.
    </div>


## Pull Requests

Pull requests are welcome and appreciated. Please make changes to the CoffeeScript source file since the JavaScript source file is automatically compiled from CoffeeScript.

## Compiling CoffeeScript

    coffee -c source/jquery.conditionaldom.coffee

#### Copyright 2012 Carl Mercier - Released under the MIT license.
