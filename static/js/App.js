App = Ember.Application.create();

App.Router.map(function() {
    this.resource('about')
    this.resource('posts')
    this.resource('welcome')
});

App.PostsRoute = Ember.Route.extend({
    model: function(){
        return $.getJSON('/posts').then(function(data){
            return data.posts;
        });
    }
});