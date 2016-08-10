import Model from 'ember-data/model';
import attr from 'ember-data/attr';
import { belongsTo, hasMany } from 'ember-data/relationships';

export default Model.extend({
  no: attr('number'),
  name: attr('string'),
  vtype: attr('string'),
  value: attr('string'),
  event: belongsTo('event')
});
