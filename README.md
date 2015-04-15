#frest_base

A user-modifiable website.

Based on the idea of frest: Functional REST. Allow REST states to be functions — requesting a function invokes it.

Give everything a path, most things a UUID.

Web requests use a key-value naming, so it's easy to curry a function that takes such named arguments.

Provide some functions that can modify the UI and do usual lambda-calculus sort of things.

Add lexifications for the operations and content.

Assume the client can generate UIs from the lexifications.

Develop a basic UI generator.

== user-modifiable website.


Notes:

watchify -g browserify-css -g [ reactify --es6 ] --standalone frest javascript/frest.js -o static/frest.js

will convert the contents of the javascript/ folder to a single static/frest.js