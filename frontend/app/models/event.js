import Model from 'ember-data/model';
import attr from 'ember-data/attr';
import { belongsTo, hasMany } from 'ember-data/relationships';

export default Model.extend({
  time: attr('number'),
  pair: belongsTo('pair'),
  variables: hasMany('variables')
});
