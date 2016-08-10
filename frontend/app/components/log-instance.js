import Ember from 'ember';

export default Ember.Component.extend({
  level: null,
 event: null, // passed-in
 
 actions: {
  save(){
   console.log('+-- save called on log-instance component');
    
   this.save();
  }
 },
 
 indent: Ember.computed('level','event',function(){
   var string = "";
    var space = ".";
   var y = this.get('level');
   for(var i = 0; i< y; i++){
    string = string.concat(space);
   }
   return string;
   
  })
});





