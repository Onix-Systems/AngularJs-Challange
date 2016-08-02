(->

  angular
    .module 'app'
    .factory 'UserFactory', ['$http', ($http) ->
      class UserFactory
        constructor: (user) ->
          @_extend(user) if user
          @errors = {}

        save: ->
          if typeof @id is 'number' then @_update() else @_create()

        _extend: (user) ->
          angular.extend this, user

        _create: ->
          self = this

          $http
            .post '/agent', @_fields()
            .success (response) ->
              self.errors = {}
              angular.extend self, response.data
            .error (response) ->
              self.errors = response.errors

        _update: ->
          self = this

          $http
            .put "/agent/#{@id}", @_fields()
            .success (response) ->
              self.errors = {}
              angular.extend self, response.data
            .error (response) ->
              self.errors = response.errors

        _fields: ->
          {
            first_name: @first_name
            last_name: @last_name
            user_type: @user_type
            office_id: @office_id
            email: @email
            phone: @phone
            email_notifications: @email_notifications
            sms_notifications: @sms_notifications
          }
    ]
)()
