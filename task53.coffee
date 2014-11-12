this.Cards = new Meteor.Collection 'cards'
this.Notes = new Meteor.Collection 'notes'

Meteor.methods
  createCard: (options) ->
    # check options
    if options.content and options.content.length > 0
      Cards.insert
        owner_id: this.userId
        content: options.content
        column: options.column

  createNote: (options) ->
    # check options
    if options.content? and options.content.length > 0 and options.card_id? and options.column?
      Notes.insert
        owner_id: this.userId
        content: options.content
        column: options.column
        card_id: options.card_id

  removeCard: (options) ->
    Cards.remove(options)
    Notes.remove(card_id: options._id)
    
  removeNote: (id) ->
    Notes.remove(_id: id)

  moveNote: (options) ->
    result = Notes.update { _id: options.id }, $set: _.omit(options, 'id')

  moveCard: (options) ->
    Cards.update { _id: options.id }, $set: _.omit(options, 'id')

  setColor: (color) ->
    console.log color
    Meteor.users.update { _id: Meteor.userId() }, $set: 'profile.taskColor': color
    console.log Meteor.user()

toggleBacklog = ->
  $('.drawer').toggleClass 'drawer--open'
  $('.wrapper').toggleClass 'wrapper--nav-open'

if Meteor.isClient
  Template.body.events
    'click .open-nav': (event, template) ->
      toggleBacklog()
      $('.drawer, .wrapper').bind 'click.close', ->
        toggleBacklog()
        $('.drawer, .wrapper').unbind 'click.close'
