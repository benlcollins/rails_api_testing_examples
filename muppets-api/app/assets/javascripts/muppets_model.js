// Model: represents the data for a *single* Muppet.
var Muppet = Backbone.Model.extend({
  defaults: {
    name: null,
    image_url: null
  }
});

// Collection: represents the data for *all* Muppets.
var Muppets = Backbone.Collection.extend({
  url: '/api',
  model: Muppet
});

var muppets = new Muppets();
muppets.fetch();