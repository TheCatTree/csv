import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    var db = Cookies.get('db_id'); 
    db = parseInt(db);
    return this.store.findRecord('error-log', db);
  }
});
