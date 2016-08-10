import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('error-logs');
  this.route('events');
  this.route('pairs');
  this.route('variables');
});

export default Router;
