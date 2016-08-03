describe 'AngularJS Challenge', ->

  beforeEach module('app')
  
  $controller = undefined
  
  beforeEach inject((_$controller_) ->
    $controller = _$controller_
    return
  )

  xdescribe 'AddUserController', ->
    beforeEach inject(($state) ->
      spyOn $state, 'go'
      return
    )

    it 'can save', inject(($http, $state, OfficesService, UserFactory) ->
      $scope = {}
      controller = $controller('AddUserController', $scope: $scope, $http: $http, $state: $state, OfficesService: OfficesService, UserFactory: UserFactory)

      expect($state.go).toHaveBeenCalled();
      return
    )
    
  describe 'ApplicationsController', ->
    $scope = undefined
    controller = undefined
    $rootScope = undefined
    $state = undefined
    $injector = undefined
    $httpBackend = undefined
    myServiceMock = undefined
    state = 'myState'

    beforeEach ->
      module 'myApp', ($provide) ->
        $provide.value 'myService', myServiceMock = {}
        return
      inject (_$rootScope_, _$state_, _$injector_, _$httpBackend_) ->
        $rootScope = _$rootScope_
        $state = _$state_
        $injector = _$injector_
        $httpBackend = _$httpBackend_;
        return
      $scope = {}
      controller = $controller('ApplicationsController', $scope: $scope, $state: $state, $http: $httpBackend, ngDialog: ngDialog)
      return
      
    it 'has pets?', ->
      group = pets: 'dog'
      expect(true).toBe(true);
      return  
    return  
  return
  