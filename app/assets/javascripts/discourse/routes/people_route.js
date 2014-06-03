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

    Discourse.User.findAll().then(function(users) {
      controller.set('users', users);  
    });
  }
});
