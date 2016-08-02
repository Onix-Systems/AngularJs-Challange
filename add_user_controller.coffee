(->

  class AddUserController
    @$inject = ['$scope', '$http', '$state', 'OfficesService', 'UserFactory']

    constructor: (@$scope, @$http, @$state, @OfficesService, UserFactory) ->
      @offices = @OfficesService
      @user = new UserFactory()
      @user_types = [
        {
          id: 'agent'
          value: 'Agent'
        }
        {
          id: 'manager'
          value: 'Manager'
        }
      ]

    save: ->
      self = this

      @user.save().then ->
        self.$state.go('app.main.users.list')



  angular
    .module('app')
    .controller('AddUserController', AddUserController)

)()
