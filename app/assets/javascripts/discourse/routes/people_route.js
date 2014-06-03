/**
  /people

  @class PeopleRoute
  @extends Discourse.Route
  @namespace Discourse
  @module Discourse

**/
Discourse.PeopleRoute = Discourse.Route.extend({
  
  setupController: function(controller, people) {
    console.log('PeopleRoute.setupController');
    controller.set('model', [{name: 'adam'}]);
  }

});
