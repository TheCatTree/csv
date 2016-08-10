import Ember from 'ember';

export default Ember.Controller.extend({
  actions: {
    save(){
      this.get('model').save();
      console.log('+--- save called on index controller');
    },
    savelog(){
     this.get('store').peekAll('variable').save();
      
      console.log( '+--- savelog called on index controller');
    }
  }
});
