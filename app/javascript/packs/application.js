import "core-js/stable";
import "regenerator-runtime/runtime";
import "../../../app/assets/javascripts/application.js";
import "../css/application.scss";
const importAll = (r) => r.keys().map(r)
importAll(require.context('../images', false, /\.(png|jpe?g|svg)$/));
importAll(require.context('../fonts', false, /\.(eot|svg|ttf|woff)$/));

const $ = require('jquery');
window.$ = $;
window.jQuery = $;

require("bootstrap/dist/js/bootstrap.min.js");
require("../../../vendor/superfish.js");
require("jquery-migrate/dist/jquery-migrate.min.js");
require("../../../vendor/placeholdem.min.js");
require("../../../vendor/hoverIntent.js");
require("../../../vendor/superfish.js");
require("../../../vendor/jquery.actual.min.js");
require("../../../vendor/jquerypp.custom.js");
require("../../../vendor/jquery.elastislide.js");
require("../../../vendor/jquery.flexslider-min.js");
require("../../../vendor/jquery.prettyPhoto.js");
require("../../../vendor/jquery.easing.1.3.js");
require("../../../vendor/jquery.ui.totop.js");
require("../../../vendor/jquery.isotope.min.js");
require("../../../vendor/jquery.easypiechart.min.js");
require("../../../vendor/jflickrfeed.min.js");
require("../../../vendor/jquery.sticky.js");
require("../../../vendor/owl.carousel.min.js");
require("../../../vendor/jquery.nicescroll.min.js");
require("../../../vendor/jquery.fractionslider.min.js");
require("../../../vendor/jquery.scrollTo-min.js");
require("../../../vendor/jquery.localscroll-min.js");
require("../../../vendor/jquery.parallax-1.1.3.js");
require("../../../vendor/jquery.bxslider.min.js");
require("../../../vendor/jquery.funnyText.min.js");
/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// Support component names relative to this directory:
var componentRequireContext = require.context("components", true);
var ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);
