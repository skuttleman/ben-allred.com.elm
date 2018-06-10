'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');

// Require static assets
require('../html/index.html');
require('../../static/images/snow.jpg');
require('../scss/main.scss');

var Elm = require('../elm/Main.elm');
var mountNode = document.getElementById('app');

// The third value on embed are the initial values for incomming ports into Elm
var app = Elm.Main.embed(mountNode);
