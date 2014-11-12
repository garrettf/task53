Template.cardsIndex.helpers
  activeCards: ->
    Cards.find is_backlog: $not: true

Template.cardCreate.events
  'click .card-create__button': (event, template) ->
    content = $(".card-create__content").val()
    Meteor.call 'createCard', content: content, column: 0

Template.card.events
  'click .card__remove': (event, template) ->
    Meteor.call 'removeCard', {_id: this._id}

Template.card.helpers
  displayName: ->
    user = Meteor.users.findOne this.owner_id
    if user and user.profile and user.profile.name
      user.profile.name
    else
      '(unknown user)'

Template.card.events
  'dragstart': (event, template) ->
    event.originalEvent.dataTransfer.setData 'Text', this._id

Template.cardColumn.helpers
  correctColumn: ->
    this.card.column == this.column
  
Template.cardColumn.events
  'dragover': (event, template) ->
    event.preventDefault()
  'drop': (event, template) ->
    event.preventDefault()
    card_id = event.originalEvent.dataTransfer.getData 'Text'
    Meteor.call 'moveCard', id: card_id, column: this.column

