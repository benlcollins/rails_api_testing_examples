// Muppets form view: manages the submission of the `#muppets-form` view.
var MuppetsFormView = Backbone.View.extend({
  el: '#muppets-form',

  events: {
    'submit': 'onSubmit'
  },

  onSubmit: function(evt) {
    // Stop default form submission:
    evt.preventDefault();

    // Create a new model within the collection:
    this.collection.create({
      name: this.$('[name="name"]').val(),
      image_url: this.$('[name="image_url"]').val()
    });

    // Reset all fields within the form element:
    this.el.reset();
  }
});


// Muppets List View: manages the list display of all muppets in the collection.
var MuppetsListView = Backbone.View.extend({
  el: '#muppets-list',

  initialize: function() {
    this.listenTo(this.collection, 'sync remove change', this.render);
    this.render();
  },

  render: function() {
    var html = '';

    this.collection.each(function(model) {
      html += '<li id="'+ model.id +'"><img src="'+ model.get('image_url') +'"> '+ model.get('name')+'</li>';
    });

    this.$el.html(html);
  }
});


var muppetsForm = new MuppetsFormView({collection: muppets});
var muppetsList = new MuppetsListView({collection: muppets});