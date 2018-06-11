'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');

// Require static assets
require('../html/index.html');
require('../scss/main.scss');

require('../../static/json/albums.json');
require('../../static/json/apps.json');
require('../../static/json/bios.json');
require('../../static/json/header.json');
require('../../static/json/songs.json');

require('../../static/images/climbing.jpg');
require('../../static/images/hiking.jpg');
require('../../static/images/music.jpg');
require('../../static/images/portfolio.jpg');
require('../../static/images/snow.jpg');
require('../../static/images/view.jpg');

require('../../static/music/itunes.png');
require('../../static/music/LetsPutThePastBackTogether.mp3');
require('../../static/music/MorningAfterPill.mp3');
require('../../static/music/slave-to-time.jpg');
require('../../static/music/story-of-my-life.jpg');
require('../../static/music/SwornToSecrecy.mp3');
require('../../static/music/TheNextStep.mp3');

var Elm = require('../elm/Main.elm');
var mountNode = document.getElementById('app');

// The third value on embed are the initial values for incomming ports into Elm
var app = Elm.Main.embed(mountNode);
