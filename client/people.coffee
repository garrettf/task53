Template.people.helpers
  people: ->
    output = Meteor.users.find()

Template.person.events
  'dragover': (event, template) ->
    event.preventDefault()
  'drop': (event, template) ->
    event.preventDefault()
    note_id = event.originalEvent.dataTransfer.getData 'Text'
    Meteor.call 'moveNote',
      id: note_id,
      owner_id: template.data._id

Template.person.helpers
  avatarURL: ->
    # Hack for test user data
    if this.profile?
      'http://avatars.githubusercontent.com/u/' + this.profile.githubId + '?v=2&s=48'
    # Use this for real user data
    #if !this.services? or !this.services.github
    #  ''
    #else
    #  'http://avatars.githubusercontent.com/u/' + this.services.github.id + '?v=2&s=48'
  color: ->
    console.log this
    if this.profile? and this.profile.taskColor?
      this.profile.taskColor

Template.colorPicker.events
  'click button': (event, template) ->
    color = $('textarea', template.firstNode).val()
    $('textarea', template.firstNode).val ''
    Meteor.call 'setColor', color


