import Model from 'ember-data/model';
import attr from 'ember-data/attr';
import { belongsTo, hasMany } from 'ember-data/relationships';

export default Model.extend({
  level: attr('number'),
  symbol: attr('string'),
  vamount: attr('number'),
  errorlog: belongsTo('error-logs'),
  events: hasMany('event')
});
