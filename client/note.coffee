Template.noteColumn.helpers
  notes: ->
    Notes.find column: this.column, card_id: this.card_id

Template.noteCreate.events
  'click .note-create__button': (event, template) ->
    content = $('.note-create__content', template.firstNode).val()
    $('.note-create__content', template.firstNode).val("")
    Meteor.call 'createNote',
      content: content,
      card_id: this.card_id,
      column: this.column
    $('.note.create').removeClass('active')
  'click .note-create__activate': (event, template) ->
    $('.note.create').removeClass('active')
    $(template.firstNode).addClass('active')
    $(template.firstNode).find('textarea').focus()
  'focusout textarea': (event, template) ->
    Meteor.setTimeout(->
      $(template.firstNode).addClass('inactive').removeClass('active')
    , 120)

Template.note.helpers
  color: ->
    user = Meteor.users.findOne( _id: this.owner_id )
    if user?
      user.profile.taskColor

Template.note.events
  'dragstart': (event, template) ->
    event.originalEvent.dataTransfer.setData 'Text', this._id

Template.noteColumn.events
  'dragover': (event, template) ->
    event.preventDefault()
  'drop': (event, template) ->
    event.preventDefault()
    note_id = event.originalEvent.dataTransfer.getData 'Text'
    Meteor.call 'moveNote',
      id: note_id,
      card_id: this.card_id,
      column: this.column

Template.trash.events
  'dragover button': (event, template) ->
    event.preventDefault()
  'drop button': (event, template) ->
    event.preventDefault()
    note_id = event.originalEvent.dataTransfer.getData 'Text'
    Meteor.call 'removeNote', note_id
