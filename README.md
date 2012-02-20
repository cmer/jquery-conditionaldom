# jquery.conditionaldom.js

ConditionalDom is a jQuery plugin that makes it easy to conditionally execute simple actions on DOM elements based on Javascript conditions.

## Behavior

By default, ConditionalDom will show an element if the statement evaluates to *true*, and hide it if it evaluates to <code>false</code>. This behavior can be changed, however. See the intermediate examples for details.

ConditionalDom will also only evaluate the conditional statement once per DOM element, unless the <code>multi</code> class is specified.

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

By default, ConditionalDom will only run the if/unless statements once, regardless of how many times the <code>conditionalDom()</code> function is called. However, if you want to execute the conditional statement to be executed multiple times, add the *multi* class to the DOM element. Such as:

    <div class="conditionalDom multi" data-if="true">
    </div>

### Advanced

ConditionalDom also lets you specify what to do after evaluating the conditional statement of the DOM element.

To do so, add some JavaScript code to the <code>data-true-action</code> or <code>data-false-action</code> attributes. The <code>e</code> and <code>$e</code> variables are available to you. <code>e</code> is the element itself, and <code>$e</code> is a shortcut to <code>$(e)</code>.

    <script>
      window.Application = {}
      Application.meta = {userId: 1, isAdmin: true};
      $(document).ready(function() { $(document).conditionalDom(); });
    </script>

    <div class="conditionalDom" data-if="Application.meta.isAdmin"
                                data-true-action="$e.innerHTML('Welcome Admin! Your user id is ' + Application.meta.userId);$e.show();"
                                data-false-action="alert('Access Denied!');$e.hide();">
    </div>

To remove an element from the DOM when the condition evaluates to <code>false</code>, just set <code>data-false-action</code> as follow:

    <div class="conditionalDom" data-if="true == false"
                                data-false-action="$e.remove();">
      This will be removed from the DOM.
    </div>


## Pull Requests

Pull requests are welcome and appreciated. Please make changes to the CoffeeScript source file since the JavaScript source file is automatically compiled from CoffeeScript.

## Compiling CoffeeScript

    coffee -c source/jquery.conditionaldom.coffee

#### Copyright 2012 Carl Mercier - Released under the MIT license.
